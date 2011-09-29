Description
===========
Little utility to investigate how to solve the binding retain cycle problem.

Usage
=====
* Launch the application
* Pick your view's className
* Click alloc to initialize and add your view to the stage
* Click release to remove your view and send it a release message, you should see a dealloc message if there are no retain cycles.

Testable Views
==============
* NSView - stock view
* RetainCycleTestView - has a binding that causes a retain cycle
* TearDownTestView - calls a teardown method when we are done using it
* SelfProxyTestView - fixed retain cycle by subclassing SelfProxyView and binding through selfProxy 

SelfProxyView based off: [http://theocacao.com/document.page/18](http://theocacao.com/document.page/18)
