run:
	nvcc -g -G -arch=sm_21 Tests/gemtc-benchmarking/mainTest.cu -o bin/mainTest
test:
	nvcc -g -G -arch=sm_21 Tests/gemtc-benchmarks/mainTest.cu -o bin/test
clean:
	rm ./bin/run
