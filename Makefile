all:
	lazbuild --build-mode= *.lpi

clean:
	if test -d lib ; then rm  -rf lib ;  fi
	if test -d LabsTweakTools  ; 	then rm LabsTweakTools  ;  fi




