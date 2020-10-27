CC_FLAGS=-Wno-narrowing

driver: main.cpp transpose.cpp tuner_msi001.c
	g++ $(CC_FLAGS) -o main $^ -lusb-1.0 -lpthread

