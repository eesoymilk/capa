all: main.out varify.exe
	./varify.exe

main.out: main.exe
	./main.exe < example.in > main.out
	
main.exe:
	g++ main.cc -o main.exe

varify.exe:
	g++ varify.cc -o varify.exe

clean:
	rm main.exe main.out varify.exe