# Glued

[![Build Status][travis-badge]][travis]
[![Code Climate][codeclimate-badge]][codeclimate]
[![Coverage Status][coveralls-badge]][coveralls]
[![Dependency Status][gemnasium-badge]][gemnasium]
[![Gem Version][gem-version-badge]][gem-version]

A Ruby client to download [HDS][hds] *recorded* fragments and glue them together. Live content isn't supported. 

The primary aim is to download video on demand content. Encrypted [DRM][] content will download, however it will not playback unless your player accomodates it and a license is available for the media.  

[HDS][hds] is designed for live media that dynamically adapts to network conditions and avoids buffering. It uses the HTTP protocol to benefit from existing network infastructre (ie [CDN][cdn]s). It is similar to [MPEG-DASH][mpeg-dash] and [HLS][hls].

## References

### Specification Documents

* [Flash Media Manifest Specification][f4m-spec]
* [Flash Video Format Specification][f4v-spec]

### Code

* [OSMF][] [httpstreaming][osmf-httpstreaming] (AS3)
* [OSMF][] [f4mClasses][osmf-f4mclasses] with [F4MLoader][osmf-f4mloader] as the entry point. (AS3)
* [HDS Union](https://github.com/AndyA/hds_union) (perl)
* [K-S-V Scripts](https://github.com/K-S-V/Scripts/blob/master/AdobeHDS.php) (php)

### Etc

* [Getting started with HDS](http://www.thekuroko.com/http-dynamic-streaming-getting-started/)
* [Fragmented MP4](http://technology-pedia.blogspot.co.uk/2012/09/fragmented-mp4-format-fmp4-f4f-adobe.html)
* [flvtool2](https://github.com/unnu/flvtool2)
* [get-flash-videos](https://github.com/monsieurvideo/get-flash-videos)
* [rtmp-dump](http://rtmpdump.mplayerhq.hu)
* [get_iplayer](https://github.com/dinkypumpkin/get_iplayer/)

### Questions / Answers / Guesses

A *box* is a convention within a stream of bytes. Each box starts with a header, which describes length and type, followed by the data in the box.

### Abbreviations

HDS - HTTP Dynamic Streaming  
F4M - Flash Media Manfiest  
F4F - Flash Media File fragment  
F4X - Flash Media Index file  
F4V - H.264/AAC based content  
FLV - Other flash supported codecs  

## How it works

Load the f4m manifest  
    - Bad url? go 💥  
    - Detect any alternate bitrate manifests? go 💥  
    - Detect a live stream? go 💥  
    - Automatically picks the higest bitrate stream  
Builds a list of fragment urls  
Download each fragment  
    - Fragment fails? go 💥  
Glue it to the previous fragment  
Repeat till done  

## License

[MIT][], see accomanying [LICENSE](LICENSE) document

[ruby]: https://www.ruby-lang.org
[hds]: http://www.adobe.com/uk/products/hds-dynamic-streaming.html "Adobe HTTP Dynamic Streaming"
[cdn]: http://en.wikipedia.org/wiki/Content_delivery_network
[hls]: http://en.wikipedia.org/wiki/HTTP_Live_Streaming
[mpeg-dash]: http://en.wikipedia.org/wiki/MPEG_DASH
[OSMF]: http://osmf.org/ "Open Source Media Framework"
[osmf-httpstreaming]: http://opensource.adobe.com/svn/opensource/osmf/trunk/framework/OSMF/org/osmf/net/httpstreaming/
[osmf-f4mclasses]: http://opensource.adobe.com/svn/opensource/osmf/trunk/framework/OSMF/org/osmf/elements/f4mClasses/
[osmf-f4mloader]: http://opensource.adobe.com/svn/opensource/osmf/trunk/framework/OSMF/org/osmf/elements/F4MLoader.as
[f4m-spec]: doc/adobe-media-manifest-specification.pdf 
[f4v-spec]: doc/adobe-flash-video-file-format-spec.pdf
[MIT]: http://opensource.org/licenses/MIT
[DRM]: http://en.wikipedia.org/wiki/Digital_rights_management

[gemnasium-badge]: https://gemnasium.com/simongregory/glued.png
[gemnasium]: https://gemnasium.com/simongregory/glued
[codeclimate-badge]: https://codeclimate.com/github/simongregory/glued.png
[codeclimate]: https://codeclimate.com/github/simongregory/glued
[travis-badge]: https://travis-ci.org/simongregory/glued.png?branch=master
[travis]: https://travis-ci.org/simongregory/glued
[coveralls-badge]: https://coveralls.io/repos/simongregory/glued/badge.png
[coveralls]: https://coveralls.io/r/simongregory/glued
[gem-version-badge]: https://badge.fury.io/rb/glued.png
[gem-version]: http://badge.fury.io/rb/glued
