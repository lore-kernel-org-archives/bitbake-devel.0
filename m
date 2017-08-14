Return-Path: <markus.megerlin@megerlin.de>
X-Greylist: delayed 450 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 14 Aug 2017 07:53:40 UTC
Received: from smtp.megerlin.de (megerlin.de [85.214.221.78])
	by mail.openembedded.org (Postfix) with ESMTP id 2FC31783BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Aug 2017 07:53:40 +0000 (UTC)
Received: from [192.168.2.102] (p5DC7CAC6.dip0.t-ipconnect.de [93.199.202.198])
	by smtp.megerlin.de (Postfix) with ESMTPSA id 6CAE35520D56;
	Mon, 14 Aug 2017 09:46:10 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
From: Markus Megerlin <markus.megerlin@megerlin.de>
Message-ID: <b2504527-5a5d-bedb-7f1f-8e0ad5ac0864@megerlin.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.2.1
MIME-Version: 1.0
X-PPP-Message-ID: <20170814074610.11702.19493@h2007878.stratoserver.net>
X-PPP-Vhost: megerlin.de
X-Mailman-Approved-At: Fri, 01 Sep 2017 15:25:32 +0000
Cc: =?UTF-8?Q?Andreas_Kr=c3=bcger?= <andreas.krueger.extern@innogy.com>
Subject: Can't get bitbake running
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
Date: Mon, 14 Aug 2017 07:53:41 -0000
X-Original-Date: Mon, 14 Aug 2017 09:46:10 +0200
X-List-Received-Date: Mon, 14 Aug 2017 07:53:41 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Dear Madams and Sirs,

I try to get bitbake running for several days. I tried the following
versions:

- 1.26

- 1.17

- 1.16

And last I also tried to checkout the branch 1.34 and use it. But this
attempt failed, too.

On Version 1.26 I get the following error message:

Traceback (most recent call last):
  File "/home/megerlin/Tools/bitbake-1.26.0/bin/bitbake", line 31, in
<module>
    import bb
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/__init__.py", line
77, in <module>
    from bb import fetch2 as fetch
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/fetch2/__init__.py",
line 1660, in <module>
    from . import wget
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/fetch2/wget.py", line
40, in <module>
    from   bs4 import BeautifulSoup
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bs4/__init__.py", line
30, in <module>
    from .builder import builder_registry, ParserRejectedMarkup
  File
"/home/megerlin/Tools/bitbake-1.26.0/lib/bs4/builder/__init__.py", line
311, in <module>
    from . import _html5lib
  File
"/home/megerlin/Tools/bitbake-1.26.0/lib/bs4/builder/_html5lib.py", line
57, in <module>
    class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder)=
:
AttributeError: 'module' object has no attribute '_base'
/home/megerlin/Tools/bitbake-1.26.0/lib/bb/event.py:111: RuntimeWarning:
Parent module 'bb' not found while handling absolute import
  from bb.msg import BBLogFormatter
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/event.py", line 111,
in print_ui_queue
    from bb.msg import BBLogFormatter
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/__init__.py", line
77, in <module>
    from bb import fetch2 as fetch
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/fetch2/__init__.py",
line 39, in <module>
    from bb import data
ImportError: cannot import name data
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/event.py", line 111,
in print_ui_queue
    from bb.msg import BBLogFormatter
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/__init__.py", line
77, in <module>
    from bb import fetch2 as fetch
  File "/home/megerlin/Tools/bitbake-1.26.0/lib/bb/fetch2/__init__.py",
line 39, in <module>
    from bb import data
ImportError: cannot import name data

But as I looked for the "data" file in the "bb" package I could find it,
where I did expect it. So I have no idea what the problem might be.

In version 1.17, as well as in version 1.16 there is another error occuri=
ng:

[...]

ERROR: Execution of event handler 'sstate_eventhandler' failed
Traceback (most recent call last):
  File "sstate_eventhandler(e)", line 6, in
sstate_eventhandler(e=3D<bb.event.RecipeParsed object at 0x7f8facf37f90>)=

TypeError: 'NoneType' object has no attribute '__getitem__'
[...]

Summary: There were 67 ERROR messages shown, returning a non-zero exit co=
de.
ERROR: Execution of event handler 'sstate_eventhandler' failed
Traceback (most recent call last):
  File "sstate_eventhandler(e)", line 6, in sstate_eventhandler
TypeError: 'NoneType' object has no attribute '__getitem__'


On the git tag 1.34 I get the following error:

NOTE: Starting bitbake server...
ERROR: Unable to start bitbake server
ERROR: Last 10 lines of server log
/home/megerlin/Projekte/Innogy/GW_Firmware/fsl-community-bsp/build/bitbak=
e-cookerdaemon.log:
  File "/home/megerlin/Tools/bitbake-1.34/lib/bb/cooker.py", line 357,
in initConfigurationData
    self.databuilder.parseBaseConfiguration()
  File "/home/megerlin/Tools/bitbake-1.34/lib/bb/cookerdata.py", line
323, in parseBaseConfiguration
    raise bb.BBHandledException
bb.BBHandledException
NOTE: Starting bitbake server...
ERROR: Error in compiling python function in
/home/megerlin/Projekte/Innogy/GW_Firmware/fsl-community-bsp/sources/poky=
/meta/classes/terminal.bbclass,
line 13:

The code lines resulting in this error were:

SyntaxError: invalid token (terminal.bbclass, line 30)


I'm using a Ubuntu 17.04. The python version installed are:

python --version
Python 2.7.13

python3 --version
Python 3.5.3

Maybe you know one of the errors and could help me to solve it.

Best Regards,

Markus Megerlin

--
Markus Megerlin                      Tel: +49 231 22 39 0810
Eichenmarkweg 28                     Fax: +49 231 22 39 0811
44267 Dortmund                       Email: markus.megerlin@megerlin.de



