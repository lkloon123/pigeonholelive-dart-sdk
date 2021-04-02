OBS_PORT=9347

dart run test/test_all_generator.dart

dart --disable-service-auth-codes \
    --enable-vm-service=$OBS_PORT \
    --pause-isolates-on-exit \
    test/.test_all_with_coverage.dart &

dart run coverage:collect_coverage \
    --port=$OBS_PORT \
    --out=coverage/coverage.json \
    --wait-paused \
    --resume-isolates

dart run coverage:format_coverage \
    --lcov \
    --in=coverage/coverage.json \
    --out=coverage/lcov.info \
    --packages=.packages \
    --report-on=lib/src \
    --check-ignore

lcov --remove 'coverage/lcov.info' -o 'coverage/lcov.info' '**/lib/src/models/*.dart'

rm  -f test/.test_all_with_coverage.dart