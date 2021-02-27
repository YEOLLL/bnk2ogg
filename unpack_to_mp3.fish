for bnk in ./BNKs/*.bnk
    quickbms ./tools/wavescan.bms $bnk quickbms_decoding
    
    for wav in ./quickbms_decoding/*.wav
        ./tools/bnkextr $wav
        mv ./$wav ./bnkextr_decoding/
    end
    
    for wav in ./bnkextr_decoding/*.wav
        ./tools/ww2ogg $wav --pcb ./tools/packed_codebooks_aoTuV_603.bin
        rm $wav
    end

    for ogg in ./bnkextr_decoding/*.ogg
        wine ./tools/revorb.exe $ogg
    end

    set filename (string sub -s 8 -l 8 $bnk)
    echo $filename
    mkdir ./output/$filename
    mv ./bnkextr_decoding/*.ogg ./output/$filename

end