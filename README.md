# Qualium

Qualium is Chat User Interface Library.

<p align="center">
<img src="https://github.com/atsushi130/Qualium/blob/master/Qualium/images/Qualium.gif" alt="Qualium" width="320"/>
</p>

## Usage

Please design a custom class that conform to the Qualia Protocols and inherit the Qualia class. 

Qualia class is conform to the QualiaObject protocol.
```swift
class Qualia: NSObject, QualiaObject {

var ID: (user: String!, qualia: String!) = ("", "")
var type: QualiaTypes = .Message

override init() {
super.init()
}

required init(ID: (user: String!, qualia: String!)) {
super.init()
self.ID = ID
}

}
```

Protocols
- `QualiaMessage`
- `QualiaImage`
- `QualiaQuestion`
- `QualiaLocation`
- `QualiaMovie` ← Coming soon ...

Second, implement `QualiumViewDelegate` and `QualiumViewDataSource`    
QualiumViewDelegate
```swift
func qualiumView(qualiumView: QualiumView, didSelectQualiaAtIndexPath indexPath: NSIndexPath)
```
```swift
func qualiumView(willSendQualia qualia: Qualia)
```

QualiumViewDataSource
```swift
func numberOfSectionInQualiumView(qualiumView: QualiumView) -> Int
```
```swift
func qualiumView(qualiumView: QualiumView, numberOfQualiasInSection section: Int) -> Int
```
```swift
func qualiumView(qualiumView: QualiumView, cellForQualiaAtIndexPath indexPath: NSIndexPath) -> QualiaCell
```

Is added new cell in time of call newQualia method.
```swift
// qualia is instance of Qualia class.
self.qualiumView.newQualia(qualia)
```

Please refer to the sample code of ViewController for more information.

## Contact

Atsushi Miyake
- https://twitter.com/tsushi130


## License (MIT)

Copyright (c) 2016 - Atsushi Miyake

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.