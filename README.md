# XMinerClient
![](https://img.shields.io/badge/swift-5.0-green.svg)
![](https://img.shields.io/badge/ios-12.0-orange.svg)
![](https://img.shields.io/badge/platform-ios-gray.svg)

Monero miner for iOS 


# Some statistics tested on iPhone 6s:


Average speed: 14 H/s (all iPhone avaliable cores)

Average temp increase per 10 minutes: 0.8 degrees Celsius 

Stable average tem: 39.2 degress Celsius


# HOW TO:


Simple run it in simulator/iOS device from xCode project. 
Everything is seted up. 


You might want to change the adress destination of pool/port/wallet and etc...
Here are they in ViewController:

```swift
startMining(address: String, url: String?, port: String?, worker: String?)
```

The implementation is looks like:
```swift
 func startMining(address: String, url: String?, port: String?, worker: String?) {
        if !isMining! {
            if !(url?.isEmpty)! && !(port?.isEmpty)! {
                miner = Miner(host: url!, port: Int(port!)!, destinationAddress: address, clientIdentifier: worker!)
            }else{
                miner = Miner(destinationAddress: address)
            }
            miner?.delegate = self
            do {
                try miner?.start(threadLimit: Int(threadsSlider.value))
                isMining = true
            }catch {
                print(error)
            }
            interraction(false)
        }else{
            isMining = false
            miner?.stop()
            interraction(true)
        }
    }
```
Yes, a lot of variables are dangerously unwrapped, had no time to make some beauty in code. Soryy for that.. :( 


# Feel free to contribute any you want to change!
