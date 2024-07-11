  #$metadatafilepath = "C:\praktika\HK_Welab_UAT1_metadata.xml"
 $outfile = ""
 
 $metadatafilepath = read-host "file path" 
 $meta = $metadatafilepath
 foreach ($file in get-childitem -Path $metadatafilepath)
 {
    
    $metadatafilepath = $metadatafilepath + "\" + $file
    $extension = (get-item $metadatafilepath).extension
    
    if ($extension -eq ".xml")
    { 
        $metadata = [xml](get-content -Path $metadatafilepath) 
        #$certificatevalue = $metadata.X509Certificate
        
        if ($metadata.GetElementsByTagName("X509Certificate") -ne "")
        {
            $certificatevalue = $metadata.GetElementsByTagName("X509Certificate"). '#text' 
            $certificate = new-object System.Security.Cryptography.X509Certificates.X509Certificate2
            $certificate.import([System.convert]::frombase64string($certificatevalue.item(0)))
            $date = $certificate.notafter
            $name=$file -Split "_"
            $bank=$name[0], $name[1], $name[2] -join "`t"
            $outfile = $outfile + $bank + "`t" + $date  + "`n"
          }
          else
          {
            if ($metadata.GetElementsByTagName("ds:X509Certificate") -ne "" )
            {
                $certificatevalue = $metadata.GetElementsByTagName("ds:X509Certificate"). '#text' 
                $certificate = new-object System.Security.Cryptography.X509Certificates.X509Certificate2
                $certificate.import([system.convert]::frombase64string($certificatevalue))
                $date = $certificate.notafter
                $name=$file -Split "_"
                $bank=$name[0], $name[1], $name[2] -join "`t"
                $outfile = $outfile + $bank + "`t" + $date  + "`n"
            }
            }
        }
    
    $metadatafilepath = $meta
    #$date | Out-File -FilePath .\Process.txt 
 }
 $metadatafilepath= $metadatafilepath + "\" + "ExpirationDate.txt"
 $outfile | Out-File -FilePath $metadatafilepath
 
