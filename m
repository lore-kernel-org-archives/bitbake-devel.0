Return-Path: <skaluzka@riseup.net>
X-Greylist: delayed 451 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 01 May 2015 19:56:29 UTC
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	by mail.openembedded.org (Postfix) with ESMTP id 10E6373DB6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 May 2015 19:56:29 +0000 (UTC)
Received: from plantcutter.riseup.net (plantcutter-pn.riseup.net [10.0.1.121])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net",
	Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id 56AE94116D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 May 2015 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1430509739; bh=iAWqBkbuwp4jLkp3P1q+/NhA+0PlFCbrg/S2tyqPxM0=;
	h=Date:From:To:Subject:From;
	b=jlaBS47xqjkvd81TGFY+nBeyhbIM/BokfHG4A1qfjHIKq91nHHfuzMvT1duqaFkBh
	FjvFlUH+YgeHOSGe/07brph5VLPSWOPTdozsPb8kkkDWGA5ozGrzUdvRMg4ydkAogV
	buBbAs6Td9fPEKshoteZCIdj/vI/GkMtC2NJ3w98=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: skaluzka) with ESMTPSA id 2B9F122727
MIME-Version: 1.0
Date: Fri, 01 May 2015 21:48:59 +0200
From: skaluzka <skaluzka@riseup.net>
To: bitbake-devel@lists.openembedded.org
Message-ID: <ecc3772510e36b5f9a21cdb194fb5c78@riseup.net>
X-Sender: skaluzka@riseup.net
User-Agent: Riseup mail
X-Virus-Scanned: clamav-milter 0.98.6 at mx1
X-Virus-Status: Clean
Subject: cannot install bitbake inside virtualenv
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
X-List-Received-Date: Fri, 01 May 2015 19:56:30 -0000
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

hello all,

I am trying to install bitbake inside virtualenv, but I am not able
to do that due to pysh import errors. I also faced missing ply issue
but I solved it with pip2 install ply. could you please help?
detailed log attached below:

[skaluzka@helium python_virtualenvs]$ virtualenv2 bbtest
New python executable in bbtest/bin/python2
Also creating executable in bbtest/bin/python
Installing setuptools, pip...done.
[skaluzka@helium python_virtualenvs]$ . bbtest/bin/activate
(bbtest)[skaluzka@helium python_virtualenvs]$ mkdir -p bbtest/tmp
(bbtest)[skaluzka@helium python_virtualenvs]$ cd bbtest/tmp/
(bbtest)[skaluzka@helium tmp]$ wget -q 
git.openembedded.org/bitbake/snapshot/bitbake-1.26.0.tar.gz
(bbtest)[skaluzka@helium tmp]$ tar zxpf bitbake-1.26.0.tar.gz
(bbtest)[skaluzka@helium tmp]$ cd bitbake-1.26.0
(bbtest)[skaluzka@helium bitbake-1.26.0]$ python2 setup.py install
running install
running build
running build_py
creating build
creating build/lib
copying lib/codegen.py -> build/lib
creating build/lib/bb
creating build/lib/bb/server
copying lib/bb/server/process.py -> build/lib/bb/server
copying lib/bb/server/xmlrpc.py -> build/lib/bb/server
copying lib/bb/server/__init__.py -> build/lib/bb/server
creating build/lib/bb/parse
creating build/lib/bb/parse/parse_py
copying lib/bb/parse/parse_py/__init__.py -> build/lib/bb/parse/parse_py
copying lib/bb/parse/parse_py/BBHandler.py -> 
build/lib/bb/parse/parse_py
copying lib/bb/parse/parse_py/ConfHandler.py -> 
build/lib/bb/parse/parse_py
copying lib/bb/parse/__init__.py -> build/lib/bb/parse
copying lib/bb/parse/ast.py -> build/lib/bb/parse
creating build/lib/bb/fetch2
copying lib/bb/fetch2/local.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/bzr.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/__init__.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/git.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/clearcase.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/osc.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/hg.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/gitannex.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/repo.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/wget.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/sftp.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/cvs.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/ssh.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/svn.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/gitsm.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/perforce.py -> build/lib/bb/fetch2
creating build/lib/bb/ui
creating build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/runningbuild.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobeventhandler.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/__init__.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/progressbar.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/progress.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/recipeselectionpage.py -> 
build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/builddetailspage.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/packageselectionpage.py -> 
build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/persistenttooltip.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/builder.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/sanitycheckpage.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/imageconfigurationpage.py -> 
build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobcolor.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobpages.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/utils.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobwidget.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hoblistmodel.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/buildmanager.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/imagedetailspage.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/uihelper.py -> build/lib/bb/ui
copying lib/bb/ui/uievent.py -> build/lib/bb/ui
copying lib/bb/ui/__init__.py -> build/lib/bb/ui
copying lib/bb/ui/depexp.py -> build/lib/bb/ui
copying lib/bb/ui/goggle.py -> build/lib/bb/ui
copying lib/bb/ui/hob.py -> build/lib/bb/ui
copying lib/bb/ui/toasterui.py -> build/lib/bb/ui
copying lib/bb/ui/ncurses.py -> build/lib/bb/ui
copying lib/bb/ui/knotty.py -> build/lib/bb/ui
copying lib/bb/ui/buildinfohelper.py -> build/lib/bb/ui
copying lib/bb/ui/puccho.py -> build/lib/bb/ui
creating build/lib/bb/pysh
copying lib/bb/pysh/__init__.py -> build/lib/bb/pysh
copying lib/bb/pysh/builtin.py -> build/lib/bb/pysh
copying lib/bb/pysh/pyshtables.py -> build/lib/bb/pysh
copying lib/bb/pysh/sherrors.py -> build/lib/bb/pysh
copying lib/bb/pysh/pyshlex.py -> build/lib/bb/pysh
copying lib/bb/pysh/subprocess_fix.py -> build/lib/bb/pysh
copying lib/bb/pysh/pyshyacc.py -> build/lib/bb/pysh
copying lib/bb/pysh/pysh.py -> build/lib/bb/pysh
copying lib/bb/pysh/lsprof.py -> build/lib/bb/pysh
copying lib/bb/pysh/interp.py -> build/lib/bb/pysh
copying lib/bb/msg.py -> build/lib/bb
copying lib/bb/process.py -> build/lib/bb
copying lib/bb/taskdata.py -> build/lib/bb
copying lib/bb/COW.py -> build/lib/bb
copying lib/bb/monitordisk.py -> build/lib/bb
copying lib/bb/persist_data.py -> build/lib/bb
copying lib/bb/checksum.py -> build/lib/bb
copying lib/bb/data.py -> build/lib/bb
copying lib/bb/cache_extra.py -> build/lib/bb
copying lib/bb/__init__.py -> build/lib/bb
copying lib/bb/cookerdata.py -> build/lib/bb
copying lib/bb/daemonize.py -> build/lib/bb
copying lib/bb/namedtuple_with_abc.py -> build/lib/bb
copying lib/bb/cache.py -> build/lib/bb
copying lib/bb/runqueue.py -> build/lib/bb
copying lib/bb/methodpool.py -> build/lib/bb
copying lib/bb/tinfoil.py -> build/lib/bb
copying lib/bb/exceptions.py -> build/lib/bb
copying lib/bb/codeparser.py -> build/lib/bb
copying lib/bb/main.py -> build/lib/bb
copying lib/bb/command.py -> build/lib/bb
copying lib/bb/providers.py -> build/lib/bb
copying lib/bb/event.py -> build/lib/bb
copying lib/bb/siggen.py -> build/lib/bb
copying lib/bb/cooker.py -> build/lib/bb
copying lib/bb/utils.py -> build/lib/bb
copying lib/bb/compat.py -> build/lib/bb
copying lib/bb/data_smart.py -> build/lib/bb
copying lib/bb/build.py -> build/lib/bb
creating build/lib/prserv
copying lib/prserv/__init__.py -> build/lib/prserv
copying lib/prserv/db.py -> build/lib/prserv
copying lib/prserv/serv.py -> build/lib/prserv
creating build/lib/bb/tests
copying lib/bb/tests/data.py -> build/lib/bb/tests
copying lib/bb/tests/__init__.py -> build/lib/bb/tests
copying lib/bb/tests/codeparser.py -> build/lib/bb/tests
copying lib/bb/tests/utils.py -> build/lib/bb/tests
copying lib/bb/tests/fetch.py -> build/lib/bb/tests
copying lib/bb/tests/cow.py -> build/lib/bb/tests
running build_scripts
creating build/scripts-2.7
copying and adjusting bin/bitbake -> build/scripts-2.7
copying and adjusting bin/bitbake-layers -> build/scripts-2.7
copying and adjusting bin/bitbake-diffsigs -> build/scripts-2.7
copying and adjusting bin/bitbake-prserv -> build/scripts-2.7
copying and adjusting bin/bitbake-selftest -> build/scripts-2.7
copying and adjusting bin/image-writer -> build/scripts-2.7
changing mode of build/scripts-2.7/bitbake from 644 to 755
changing mode of build/scripts-2.7/bitbake-layers from 644 to 755
changing mode of build/scripts-2.7/bitbake-diffsigs from 644 to 755
changing mode of build/scripts-2.7/bitbake-prserv from 644 to 755
changing mode of build/scripts-2.7/bitbake-selftest from 644 to 755
changing mode of build/scripts-2.7/image-writer from 644 to 755

******** Building bitbake-user-manual

cd bitbake-user-manual; xsltproc --stringparam html.stylesheet 
bitbake-user-manual-style.css --stringparam  chapter.autolabel 1 
--stringparam  section.autolabel 1 --stringparam  
section.label.includes.component.label 1 --xinclude -o 
bitbake-user-manual.html bitbake-user-manual-customization.xsl 
bitbake-user-manual.xml; cd ..
Note: namesp. cut : stripped namespace before processing
             BitBake User Manual

Note: namesp. cut : processing stripped document
             BitBake User Manual

running install_lib
copying build/lib/codegen.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/msg.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/process.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/taskdata.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/COW.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/monitordisk.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/persist_data.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/checksum.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/data.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cache_extra.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cookerdata.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/local.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/bzr.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/git.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/clearcase.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/osc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/hg.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/gitannex.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/repo.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/wget.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/sftp.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/cvs.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/ssh.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/svn.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/gitsm.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/perforce.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/daemonize.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/namedtuple_with_abc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cache.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/runqueue.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/methodpool.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/data.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/codeparser.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/utils.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/fetch.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/cow.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tinfoil.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/uihelper.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/uievent.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/depexp.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/goggle.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/hob.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/toasterui.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/runningbuild.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobeventhandler.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/progressbar.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/progress.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/recipeselectionpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/builddetailspage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/packageselectionpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/persistenttooltip.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/builder.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/sanitycheckpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/imageconfigurationpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobcolor.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobpages.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/utils.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobwidget.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hoblistmodel.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/buildmanager.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/imagedetailspage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/ncurses.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/knotty.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/buildinfohelper.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/puccho.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/exceptions.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/builtin.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pyshtables.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/sherrors.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pyshlex.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/subprocess_fix.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pyshyacc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pysh.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/lsprof.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/interp.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/codeparser.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/main.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/command.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/providers.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/event.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/siggen.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cooker.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/utils.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse
copying build/lib/bb/parse/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse
copying build/lib/bb/parse/ast.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/parse/parse_py/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/parse/parse_py/BBHandler.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/parse/parse_py/ConfHandler.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/compat.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/data_smart.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/build.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
copying build/lib/bb/server/process.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
copying build/lib/bb/server/xmlrpc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
copying build/lib/bb/server/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
copying build/lib/prserv/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
copying build/lib/prserv/db.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
copying build/lib/prserv/serv.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/codegen.py 
to codegen.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/msg.py 
to msg.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/process.py 
to process.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/taskdata.py 
to taskdata.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/COW.py 
to COW.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/monitordisk.py 
to monitordisk.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/persist_data.py 
to persist_data.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/checksum.py 
to checksum.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py 
to data.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cache_extra.py 
to cache_extra.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cookerdata.py 
to cookerdata.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/local.py 
to local.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/bzr.py 
to bzr.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/git.py 
to git.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/clearcase.py 
to clearcase.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/osc.py 
to osc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/hg.py 
to hg.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/gitannex.py 
to gitannex.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/repo.py 
to repo.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/wget.py 
to wget.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/sftp.py 
to sftp.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/cvs.py 
to cvs.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/ssh.py 
to ssh.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/svn.py 
to svn.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/gitsm.py 
to gitsm.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/perforce.py 
to perforce.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/daemonize.py 
to daemonize.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/namedtuple_with_abc.py 
to namedtuple_with_abc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cache.py 
to cache.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/runqueue.py 
to runqueue.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/methodpool.py 
to methodpool.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/data.py 
to data.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/codeparser.py 
to codeparser.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/utils.py 
to utils.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/fetch.py 
to fetch.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/cow.py 
to cow.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tinfoil.py 
to tinfoil.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/uihelper.py 
to uihelper.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/uievent.py 
to uievent.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/depexp.py 
to depexp.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/goggle.py 
to goggle.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/hob.py 
to hob.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/toasterui.py 
to toasterui.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/runningbuild.py 
to runningbuild.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobeventhandler.py 
to hobeventhandler.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/progressbar.py 
to progressbar.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/progress.py 
to progress.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/recipeselectionpage.py 
to recipeselectionpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/builddetailspage.py 
to builddetailspage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/packageselectionpage.py 
to packageselectionpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/persistenttooltip.py 
to persistenttooltip.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/builder.py 
to builder.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/sanitycheckpage.py 
to sanitycheckpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/imageconfigurationpage.py 
to imageconfigurationpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobcolor.py 
to hobcolor.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobpages.py 
to hobpages.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/utils.py 
to utils.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobwidget.py 
to hobwidget.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hoblistmodel.py 
to hoblistmodel.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/buildmanager.py 
to buildmanager.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/imagedetailspage.py 
to imagedetailspage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/ncurses.py 
to ncurses.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/knotty.py 
to knotty.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/buildinfohelper.py 
to buildinfohelper.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/puccho.py 
to puccho.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/exceptions.py 
to exceptions.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/builtin.py 
to builtin.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshtables.py 
to pyshtables.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/sherrors.py 
to sherrors.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshlex.py 
to pyshlex.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/subprocess_fix.py 
to subprocess_fix.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py 
to pyshyacc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pysh.py 
to pysh.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/lsprof.py 
to lsprof.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/interp.py 
to interp.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py 
to codeparser.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/main.py 
to main.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/command.py 
to command.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/providers.py 
to providers.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py 
to event.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/siggen.py 
to siggen.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cooker.py 
to cooker.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/utils.py 
to utils.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/ast.py 
to ast.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py/BBHandler.py 
to BBHandler.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py 
to ConfHandler.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/compat.py 
to compat.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py 
to data_smart.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/build.py 
to build.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server/process.py 
to process.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server/xmlrpc.py 
to xmlrpc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv/db.py 
to db.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv/serv.py 
to serv.pyc
running install_scripts
copying build/scripts-2.7/image-writer -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-diffsigs -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-prserv -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-selftest -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-layers -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/image-writer to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-diffsigs to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-prserv to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-selftest to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-layers to 755
changing mode of /home/skaluzka/python_virtualenvs/bbtest/bin/bitbake to 
755
running install_data
creating /home/skaluzka/python_virtualenvs/bbtest/share
creating /home/skaluzka/python_virtualenvs/bbtest/share/bitbake
copying conf/bitbake.conf -> 
/home/skaluzka/python_virtualenvs/bbtest/share/bitbake
copying classes/base.bbclass -> 
/home/skaluzka/python_virtualenvs/bbtest/share/bitbake
creating /home/skaluzka/python_virtualenvs/bbtest/share/doc
creating 
/home/skaluzka/python_virtualenvs/bbtest/share/doc/bitbake-1.26.0
creating 
/home/skaluzka/python_virtualenvs/bbtest/share/doc/bitbake-1.26.0/bitbake-user-manual
running install_egg_info
Writing 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bitbake-1.26.0-py2.7.egg-info

(bbtest)[skaluzka@helium bitbake-1.26.0]$ python2 setup.py install
running install
running build
running build_py
creating build
creating build/lib
copying lib/codegen.py -> build/lib
creating build/lib/bb
creating build/lib/bb/server
copying lib/bb/server/process.py -> build/lib/bb/server
copying lib/bb/server/xmlrpc.py -> build/lib/bb/server
copying lib/bb/server/__init__.py -> build/lib/bb/server
creating build/lib/bb/parse
creating build/lib/bb/parse/parse_py
copying lib/bb/parse/parse_py/__init__.py -> build/lib/bb/parse/parse_py
copying lib/bb/parse/parse_py/BBHandler.py -> 
build/lib/bb/parse/parse_py
copying lib/bb/parse/parse_py/ConfHandler.py -> 
build/lib/bb/parse/parse_py
copying lib/bb/parse/__init__.py -> build/lib/bb/parse
copying lib/bb/parse/ast.py -> build/lib/bb/parse
creating build/lib/bb/fetch2
copying lib/bb/fetch2/local.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/bzr.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/__init__.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/git.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/clearcase.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/osc.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/hg.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/gitannex.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/repo.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/wget.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/sftp.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/cvs.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/ssh.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/svn.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/gitsm.py -> build/lib/bb/fetch2
copying lib/bb/fetch2/perforce.py -> build/lib/bb/fetch2
creating build/lib/bb/ui
creating build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/runningbuild.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobeventhandler.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/__init__.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/progressbar.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/progress.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/recipeselectionpage.py -> 
build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/builddetailspage.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/packageselectionpage.py -> 
build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/persistenttooltip.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/builder.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/sanitycheckpage.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/imageconfigurationpage.py -> 
build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobcolor.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobpages.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/utils.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hobwidget.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/hoblistmodel.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/buildmanager.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/crumbs/imagedetailspage.py -> build/lib/bb/ui/crumbs
copying lib/bb/ui/uihelper.py -> build/lib/bb/ui
copying lib/bb/ui/uievent.py -> build/lib/bb/ui
copying lib/bb/ui/__init__.py -> build/lib/bb/ui
copying lib/bb/ui/depexp.py -> build/lib/bb/ui
copying lib/bb/ui/goggle.py -> build/lib/bb/ui
copying lib/bb/ui/hob.py -> build/lib/bb/ui
copying lib/bb/ui/toasterui.py -> build/lib/bb/ui
copying lib/bb/ui/ncurses.py -> build/lib/bb/ui
copying lib/bb/ui/knotty.py -> build/lib/bb/ui
copying lib/bb/ui/buildinfohelper.py -> build/lib/bb/ui
copying lib/bb/ui/puccho.py -> build/lib/bb/ui
creating build/lib/bb/pysh
copying lib/bb/pysh/__init__.py -> build/lib/bb/pysh
copying lib/bb/pysh/builtin.py -> build/lib/bb/pysh
copying lib/bb/pysh/pyshtables.py -> build/lib/bb/pysh
copying lib/bb/pysh/sherrors.py -> build/lib/bb/pysh
copying lib/bb/pysh/pyshlex.py -> build/lib/bb/pysh
copying lib/bb/pysh/subprocess_fix.py -> build/lib/bb/pysh
copying lib/bb/pysh/pyshyacc.py -> build/lib/bb/pysh
copying lib/bb/pysh/pysh.py -> build/lib/bb/pysh
copying lib/bb/pysh/lsprof.py -> build/lib/bb/pysh
copying lib/bb/pysh/interp.py -> build/lib/bb/pysh
copying lib/bb/msg.py -> build/lib/bb
copying lib/bb/process.py -> build/lib/bb
copying lib/bb/taskdata.py -> build/lib/bb
copying lib/bb/COW.py -> build/lib/bb
copying lib/bb/monitordisk.py -> build/lib/bb
copying lib/bb/persist_data.py -> build/lib/bb
copying lib/bb/checksum.py -> build/lib/bb
copying lib/bb/data.py -> build/lib/bb
copying lib/bb/cache_extra.py -> build/lib/bb
copying lib/bb/__init__.py -> build/lib/bb
copying lib/bb/cookerdata.py -> build/lib/bb
copying lib/bb/daemonize.py -> build/lib/bb
copying lib/bb/namedtuple_with_abc.py -> build/lib/bb
copying lib/bb/cache.py -> build/lib/bb
copying lib/bb/runqueue.py -> build/lib/bb
copying lib/bb/methodpool.py -> build/lib/bb
copying lib/bb/tinfoil.py -> build/lib/bb
copying lib/bb/exceptions.py -> build/lib/bb
copying lib/bb/codeparser.py -> build/lib/bb
copying lib/bb/main.py -> build/lib/bb
copying lib/bb/command.py -> build/lib/bb
copying lib/bb/providers.py -> build/lib/bb
copying lib/bb/event.py -> build/lib/bb
copying lib/bb/siggen.py -> build/lib/bb
copying lib/bb/cooker.py -> build/lib/bb
copying lib/bb/utils.py -> build/lib/bb
copying lib/bb/compat.py -> build/lib/bb
copying lib/bb/data_smart.py -> build/lib/bb
copying lib/bb/build.py -> build/lib/bb
creating build/lib/prserv
copying lib/prserv/__init__.py -> build/lib/prserv
copying lib/prserv/db.py -> build/lib/prserv
copying lib/prserv/serv.py -> build/lib/prserv
creating build/lib/bb/tests
copying lib/bb/tests/data.py -> build/lib/bb/tests
copying lib/bb/tests/__init__.py -> build/lib/bb/tests
copying lib/bb/tests/codeparser.py -> build/lib/bb/tests
copying lib/bb/tests/utils.py -> build/lib/bb/tests
copying lib/bb/tests/fetch.py -> build/lib/bb/tests
copying lib/bb/tests/cow.py -> build/lib/bb/tests
running build_scripts
creating build/scripts-2.7
copying and adjusting bin/bitbake -> build/scripts-2.7
copying and adjusting bin/bitbake-layers -> build/scripts-2.7
copying and adjusting bin/bitbake-diffsigs -> build/scripts-2.7
copying and adjusting bin/bitbake-prserv -> build/scripts-2.7
copying and adjusting bin/bitbake-selftest -> build/scripts-2.7
copying and adjusting bin/image-writer -> build/scripts-2.7
changing mode of build/scripts-2.7/bitbake from 644 to 755
changing mode of build/scripts-2.7/bitbake-layers from 644 to 755
changing mode of build/scripts-2.7/bitbake-diffsigs from 644 to 755
changing mode of build/scripts-2.7/bitbake-prserv from 644 to 755
changing mode of build/scripts-2.7/bitbake-selftest from 644 to 755
changing mode of build/scripts-2.7/image-writer from 644 to 755

******** Building bitbake-user-manual

cd bitbake-user-manual; xsltproc --stringparam html.stylesheet 
bitbake-user-manual-style.css --stringparam  chapter.autolabel 1 
--stringparam  section.autolabel 1 --stringparam  
section.label.includes.component.label 1 --xinclude -o 
bitbake-user-manual.html bitbake-user-manual-customization.xsl 
bitbake-user-manual.xml; cd ..
Note: namesp. cut : stripped namespace before processing
             BitBake User Manual

Note: namesp. cut : processing stripped document
             BitBake User Manual

running install_lib
copying build/lib/codegen.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/msg.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/process.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/taskdata.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/COW.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/monitordisk.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/persist_data.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/checksum.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/data.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cache_extra.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cookerdata.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/local.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/bzr.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/git.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/clearcase.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/osc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/hg.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/gitannex.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/repo.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/wget.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/sftp.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/cvs.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/ssh.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/svn.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/gitsm.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/fetch2/perforce.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2
copying build/lib/bb/daemonize.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/namedtuple_with_abc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cache.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/runqueue.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/methodpool.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/data.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/codeparser.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/utils.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/fetch.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tests/cow.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests
copying build/lib/bb/tinfoil.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/uihelper.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/uievent.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/depexp.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/goggle.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/hob.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/toasterui.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/runningbuild.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobeventhandler.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/progressbar.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/progress.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/recipeselectionpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/builddetailspage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/packageselectionpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/persistenttooltip.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/builder.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/sanitycheckpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/imageconfigurationpage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobcolor.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobpages.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/utils.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hobwidget.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/hoblistmodel.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/buildmanager.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/crumbs/imagedetailspage.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs
copying build/lib/bb/ui/ncurses.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/knotty.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/buildinfohelper.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/ui/puccho.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui
copying build/lib/bb/exceptions.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/builtin.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pyshtables.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/sherrors.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pyshlex.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/subprocess_fix.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pyshyacc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/pysh.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/lsprof.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/pysh/interp.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh
copying build/lib/bb/codeparser.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/main.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/command.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/providers.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/event.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/siggen.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/cooker.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/utils.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse
copying build/lib/bb/parse/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse
copying build/lib/bb/parse/ast.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/parse/parse_py/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/parse/parse_py/BBHandler.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/parse/parse_py/ConfHandler.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py
copying build/lib/bb/compat.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/data_smart.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
copying build/lib/bb/build.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
copying build/lib/bb/server/process.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
copying build/lib/bb/server/xmlrpc.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
copying build/lib/bb/server/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server
creating 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
copying build/lib/prserv/__init__.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
copying build/lib/prserv/db.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
copying build/lib/prserv/serv.py -> 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/codegen.py 
to codegen.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/msg.py 
to msg.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/process.py 
to process.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/taskdata.py 
to taskdata.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/COW.py 
to COW.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/monitordisk.py 
to monitordisk.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/persist_data.py 
to persist_data.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/checksum.py 
to checksum.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py 
to data.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cache_extra.py 
to cache_extra.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cookerdata.py 
to cookerdata.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/local.py 
to local.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/bzr.py 
to bzr.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/git.py 
to git.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/clearcase.py 
to clearcase.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/osc.py 
to osc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/hg.py 
to hg.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/gitannex.py 
to gitannex.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/repo.py 
to repo.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/wget.py 
to wget.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/sftp.py 
to sftp.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/cvs.py 
to cvs.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/ssh.py 
to ssh.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/svn.py 
to svn.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/gitsm.py 
to gitsm.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/perforce.py 
to perforce.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/daemonize.py 
to daemonize.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/namedtuple_with_abc.py 
to namedtuple_with_abc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cache.py 
to cache.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/runqueue.py 
to runqueue.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/methodpool.py 
to methodpool.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/data.py 
to data.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/codeparser.py 
to codeparser.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/utils.py 
to utils.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/fetch.py 
to fetch.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tests/cow.py 
to cow.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/tinfoil.py 
to tinfoil.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/uihelper.py 
to uihelper.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/uievent.py 
to uievent.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/depexp.py 
to depexp.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/goggle.py 
to goggle.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/hob.py 
to hob.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/toasterui.py 
to toasterui.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/runningbuild.py 
to runningbuild.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobeventhandler.py 
to hobeventhandler.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/progressbar.py 
to progressbar.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/progress.py 
to progress.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/recipeselectionpage.py 
to recipeselectionpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/builddetailspage.py 
to builddetailspage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/packageselectionpage.py 
to packageselectionpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/persistenttooltip.py 
to persistenttooltip.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/builder.py 
to builder.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/sanitycheckpage.py 
to sanitycheckpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/imageconfigurationpage.py 
to imageconfigurationpage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobcolor.py 
to hobcolor.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobpages.py 
to hobpages.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/utils.py 
to utils.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hobwidget.py 
to hobwidget.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/hoblistmodel.py 
to hoblistmodel.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/buildmanager.py 
to buildmanager.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/crumbs/imagedetailspage.py 
to imagedetailspage.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/ncurses.py 
to ncurses.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/knotty.py 
to knotty.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/buildinfohelper.py 
to buildinfohelper.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/ui/puccho.py 
to puccho.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/exceptions.py 
to exceptions.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/builtin.py 
to builtin.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshtables.py 
to pyshtables.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/sherrors.py 
to sherrors.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshlex.py 
to pyshlex.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/subprocess_fix.py 
to subprocess_fix.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py 
to pyshyacc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pysh.py 
to pysh.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/lsprof.py 
to lsprof.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/interp.py 
to interp.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py 
to codeparser.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/main.py 
to main.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/command.py 
to command.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/providers.py 
to providers.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py 
to event.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/siggen.py 
to siggen.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/cooker.py 
to cooker.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/utils.py 
to utils.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/ast.py 
to ast.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py/BBHandler.py 
to BBHandler.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/parse/parse_py/ConfHandler.py 
to ConfHandler.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/compat.py 
to compat.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py 
to data_smart.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/build.py 
to build.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server/process.py 
to process.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server/xmlrpc.py 
to xmlrpc.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/server/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv/__init__.py 
to __init__.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv/db.py 
to db.pyc
byte-compiling 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/prserv/serv.py 
to serv.pyc
running install_scripts
copying build/scripts-2.7/image-writer -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-diffsigs -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-prserv -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-selftest -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake-layers -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
copying build/scripts-2.7/bitbake -> 
/home/skaluzka/python_virtualenvs/bbtest/bin
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/image-writer to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-diffsigs to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-prserv to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-selftest to 755
changing mode of 
/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake-layers to 755
changing mode of /home/skaluzka/python_virtualenvs/bbtest/bin/bitbake to 
755
running install_data
creating /home/skaluzka/python_virtualenvs/bbtest/share
creating /home/skaluzka/python_virtualenvs/bbtest/share/bitbake
copying conf/bitbake.conf -> 
/home/skaluzka/python_virtualenvs/bbtest/share/bitbake
copying classes/base.bbclass -> 
/home/skaluzka/python_virtualenvs/bbtest/share/bitbake
creating /home/skaluzka/python_virtualenvs/bbtest/share/doc
creating 
/home/skaluzka/python_virtualenvs/bbtest/share/doc/bitbake-1.26.0
creating 
/home/skaluzka/python_virtualenvs/bbtest/share/doc/bitbake-1.26.0/bitbake-user-manual
running install_egg_info
Writing 
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bitbake-1.26.0-py2.7.egg-info

(bbtest)[skaluzka@helium bitbake-1.26.0]$ bitbake --version
Traceback (most recent call last):
   File "/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake", line 31, 
in <module>
     import bb
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py", 
line 77, in <module>
     from bb import fetch2 as fetch
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py", 
line 39, in <module>
     from bb import data
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py", 
line 48, in <module>
     from bb import data_smart
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py", 
line 35, in <module>
     import bb, bb.codeparser
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py", 
line 7, in <module>
     from pysh import pyshyacc, pyshlex, sherrors
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py", 
line 13, in <module>
     import pyshlex
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshlex.py", 
line 22, in <module>
     from ply import lex
ImportError: No module named ply
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py:111: 
RuntimeWarning: Parent module 'bb' not found while handling absolute 
import
   from bb.msg import BBLogFormatter
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
   File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
     func(*targs, **kargs)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py", 
line 111, in print_ui_queue
     from bb.msg import BBLogFormatter
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py", 
line 77, in <module>
     from bb import fetch2 as fetch
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py", 
line 39, in <module>
     from bb import data
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py", 
line 48, in <module>
     from bb import data_smart
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py", 
line 35, in <module>
     import bb, bb.codeparser
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py", 
line 7, in <module>
     from pysh import pyshyacc, pyshlex, sherrors
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py", 
line 13, in <module>
     import pyshlex
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshlex.py", 
line 22, in <module>
     from ply import lex
ImportError: No module named ply
Error in sys.exitfunc:
Traceback (most recent call last):
   File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
     func(*targs, **kargs)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py", 
line 111, in print_ui_queue
     from bb.msg import BBLogFormatter
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py", 
line 77, in <module>
     from bb import fetch2 as fetch
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py", 
line 39, in <module>
     from bb import data
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py", 
line 48, in <module>
     from bb import data_smart
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py", 
line 35, in <module>
     import bb, bb.codeparser
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py", 
line 7, in <module>
     from pysh import pyshyacc, pyshlex, sherrors
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py", 
line 13, in <module>
     import pyshlex
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshlex.py", 
line 22, in <module>
     from ply import lex
ImportError: No module named ply

(bbtest)[skaluzka@helium bitbake-1.26.0]$ pip2 install ply
Collecting ply
   Downloading ply-3.6.tar.gz (281kB)
     100% |████████████████████████████████| 282kB 83kB/s
Installing collected packages: ply
   Running setup.py install for ply
Successfully installed ply-3.6
(bbtest)[skaluzka@helium bitbake-1.26.0]$

(bbtest)[skaluzka@helium bitbake-1.26.0]$ bitbake --version
Traceback (most recent call last):
   File "/home/skaluzka/python_virtualenvs/bbtest/bin/bitbake", line 31, 
in <module>
     import bb
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py", 
line 77, in <module>
     from bb import fetch2 as fetch
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py", 
line 39, in <module>
     from bb import data
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py", 
line 48, in <module>
     from bb import data_smart
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py", 
line 35, in <module>
     import bb, bb.codeparser
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py", 
line 7, in <module>
     from pysh import pyshyacc, pyshlex, sherrors
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py", 
line 657, in <module>
     yacc.yacc(tabmodule = 'pysh.pyshtables', write_tables = 0, debug = 
0)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/ply/yacc.py", 
line 3212, in yacc
     exec('import %s' % pkgname)
   File "<string>", line 1, in <module>
ImportError: No module named pysh
/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py:111: 
RuntimeWarning: Parent module 'bb' not found while handling absolute 
import
   from bb.msg import BBLogFormatter
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
   File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
     func(*targs, **kargs)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py", 
line 111, in print_ui_queue
     from bb.msg import BBLogFormatter
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py", 
line 77, in <module>
     from bb import fetch2 as fetch
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py", 
line 39, in <module>
     from bb import data
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py", 
line 48, in <module>
     from bb import data_smart
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py", 
line 35, in <module>
     import bb, bb.codeparser
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py", 
line 7, in <module>
     from pysh import pyshyacc, pyshlex, sherrors
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py", 
line 657, in <module>
     yacc.yacc(tabmodule = 'pysh.pyshtables', write_tables = 0, debug = 
0)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/ply/yacc.py", 
line 3212, in yacc
     exec('import %s' % pkgname)
   File "<string>", line 1, in <module>
ImportError: No module named pysh
Error in sys.exitfunc:
Traceback (most recent call last):
   File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
     func(*targs, **kargs)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/event.py", 
line 111, in print_ui_queue
     from bb.msg import BBLogFormatter
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/__init__.py", 
line 77, in <module>
     from bb import fetch2 as fetch
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/fetch2/__init__.py", 
line 39, in <module>
     from bb import data
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data.py", 
line 48, in <module>
     from bb import data_smart
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/data_smart.py", 
line 35, in <module>
     import bb, bb.codeparser
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/codeparser.py", 
line 7, in <module>
     from pysh import pyshyacc, pyshlex, sherrors
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/bb/pysh/pyshyacc.py", 
line 657, in <module>
     yacc.yacc(tabmodule = 'pysh.pyshtables', write_tables = 0, debug = 
0)
   File 
"/home/skaluzka/python_virtualenvs/bbtest/lib/python2.7/site-packages/ply/yacc.py", 
line 3212, in yacc
     exec('import %s' % pkgname)
   File "<string>", line 1, in <module>
ImportError: No module named pysh
(bbtest)[skaluzka@helium bitbake-1.26.0]$

-- 
regards,
S


