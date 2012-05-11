Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gopikrishnans@pec.edu>) id 1SSjlt-0002SM-Q7
	for bitbake-devel@lists.openembedded.org;
	Fri, 11 May 2012 08:56:13 +0200
Received: by bkcjm2 with SMTP id jm2so2086109bkc.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 23:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type
	:x-gm-message-state;
	bh=29k58nk1MTU1LoSwVfWbc4DOKx1jo69iJyM3xg6pk/M=;
	b=hRsS5aMexhnHIZKvRlrgu41bdm8PbP4d+Jo4OAjNb2aK08AZFszbCHKP0eHBn9v5vv
	WFf+XGUhwrfY9Bxq35+OdKhqbcU4YIB8xVgHN/ZGbQ4jNnRdV/hvKsmJ8iqa2mEGmxoO
	8wGfbs07VbYHRw2j6542bjgkwlYnYztTqLr9Q/UHHRGawDJeXFxZzkJ+jNsKZomgsQKE
	HwrTmPbxGzYhjxUx4zKN7mzwAobHnwLCH/cNZOmm7Ft+fO/E6pAoX3+SupXDuqNu9RhB
	OVmIfI7KshIfNKXXbAaGOoMc2uWrKfj9X7kFMORP9PMvzQrGJLCtkEhXyQw+4xL1ARM+
	7X3g==
MIME-Version: 1.0
Received: by 10.204.154.138 with SMTP id o10mr3302bkw.34.1336718778238; Thu,
	10 May 2012 23:46:18 -0700 (PDT)
Received: by 10.204.233.80 with HTTP; Thu, 10 May 2012 23:46:18 -0700 (PDT)
Date: Fri, 11 May 2012 12:16:18 +0530
Message-ID: <CAOkC3RZ_mRLa8pmPEJKx-Qx=EfLN-Y8Ffsuchm_bAZ9gLGdpSQ@mail.gmail.com>
From: GOPIKRISHNAN S <gopikrishnans@pec.edu>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQnOyFANbQxzPuooi3FijaYkrGu1pdcQfJvBQGQa2y6VG4VmYB8qAn2ci4Ci7QFFAmhH5AZ4
Subject: QorIQ_SDK-20110709-systembuilder
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 11 May 2012 06:56:14 -0000
Content-Type: multipart/alternative; boundary=0015175df216f105aa04bfbd17d4

--0015175df216f105aa04bfbd17d4
Content-Type: text/plain; charset=ISO-8859-1

Hello,

       I am n newbie working on QorIQ_SDK-20110709-systembuilder +
Patches_V1_03_20110929;


    * I have installed clamav using

     # echo "PROJECT_EXTRA_PKGS += \clamav"\" >
/mycollection/recipies/images/amend.inc

    Its installed. When I tried installing dpkg using same procedure; I got
error message as below
    # echo "PROJECT_EXTRA_PKGS += \dpkg"\" >
/mycollection/recipies/images/amend.inc

*gopi@gopi-desktop:/media/325GB_Drive/fs_dev/p2020_20110709$ bitbake
devel-image
NOTE: Handling BitBake files: | (0386/0386) [100 %]
Parsing of 386 .bb files complete (380 cached, 6 parsed). 515 targets, 1
skipped, 0 masked, 0 errors.
ERROR: '['/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/
devel-image.bb']' RDEPENDS/RRECOMMENDS or otherwise requires the runtime
entity 'dpkg' but it wasn't found in any PACKAGE or RPROVIDES variables
ERROR: Required build target 'devel-image' has no buildable providers.
Missing or unbuildable dependency chain was: ['devel-image', 'dpkg']
NOTE: Resolving any missing task queue dependencies
ERROR: '['/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/
devel-image.bb']' RDEPENDS/RRECOMMENDS or otherwise requires the runtime
entity 'dpkg' but it wasn't found in any PACKAGE or RPROVIDES variables
Unknown Event: <bb.event.NoProvider instance at 0x9e0ecec>
NOTE: Runtime target 'dpkg' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['dpkg']
ERROR: Required build target 'devel-image' has no buildable providers.
Missing or unbuildable dependency chain was: ['devel-image', 'dpkg']
Command execution failed: Traceback (most recent call last):
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/command.py",
line 88, in runAsyncCommand
    commandmethod(self.cmds_async, self, options)
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/command.py",
line 174, in buildTargets
    command.cooker.buildTargets(pkgs_to_build, task)
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/cooker.py",
line 784, in buildTargets
    taskdata.add_unresolved(localdata, self.status)
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py",
line 562, in add_unresolved
    self.remove_runtarget(self.getrun_id(target))
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py",
line 535, in remove_runtarget
    self.fail_fnid(fnid, missing_list)
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py",
line 490, in fail_fnid
    self.remove_buildtarget(target, missing_list)
  File
"/media/325GB_Drive/fs_dev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py",
line 519, in remove_buildtarget
    raise bb.providers.NoProvider
NoProvider


Where I should provide the configurations/specification for source...
*



Reg,
Gopi Krishnan S

--0015175df216f105aa04bfbd17d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>=A0=A0=A0=A0=A0=A0 I am n newbie working on QorIQ_SDK-2011070=
9-systembuilder + Patches_V1_03_20110929;<br><br><br>=A0=A0=A0 * I have ins=
talled clamav using <br><br>=A0=A0=A0=A0 # echo &quot;PROJECT_EXTRA_PKGS +=
=3D \clamav&quot;\&quot; &gt; /mycollection/recipies/images/amend.inc<br>
<br>=A0=A0=A0 Its installed. When I tried installing dpkg using same proced=
ure; I got error message as below<br>=A0=A0=A0 # echo &quot;PROJECT_EXTRA_P=
KGS +=3D \dpkg&quot;\&quot; &gt; /mycollection/recipies/images/amend.inc<br=
><font><br>
</font><b style=3D"color:rgb(255,0,0)"><font><span style=3D"color:rgb(102,1=
02,0)">gopi@gopi-desktop:/media/325GB_Drive/fs_dev/p2020_20110709$ bitbake =
devel-image</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color:r=
gb(102,102,0)">NOTE: Handling BitBake files: | (0386/0386) [100 %]</span><b=
r style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">Parsing of 386 .bb files complete (380=
 cached, 6 parsed). 515 targets, 1 skipped, 0 masked, 0 errors.</span><br s=
tyle=3D"color:rgb(102,102,0)"><span style=3D"color:rgb(102,102,0)">ERROR: &=
#39;[&#39;/media/325GB_Drive/fs_dev/p2020_20110709/sb-core/recipes/images/<=
a href=3D"http://devel-image.bb">devel-image.bb</a>&#39;]&#39; RDEPENDS/RRE=
COMMENDS or otherwise requires the runtime entity &#39;dpkg&#39; but it was=
n&#39;t found in any PACKAGE or RPROVIDES variables</span><br style=3D"colo=
r:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">ERROR: Required build target &#39;deve=
l-image&#39; has no buildable providers.</span><br style=3D"color:rgb(102,1=
02,0)"><span style=3D"color:rgb(102,102,0)">Missing or unbuildable dependen=
cy chain was: [&#39;devel-image&#39;, &#39;dpkg&#39;]</span><br style=3D"co=
lor:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">NOTE: Resolving any missing task queue=
 dependencies</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color=
:rgb(102,102,0)">ERROR: &#39;[&#39;/media/325GB_Drive/fs_dev/p2020_20110709=
/sb-core/recipes/images/<a href=3D"http://devel-image.bb">devel-image.bb</a=
>&#39;]&#39; RDEPENDS/RRECOMMENDS or otherwise requires the runtime entity =
&#39;dpkg&#39; but it wasn&#39;t found in any PACKAGE or RPROVIDES variable=
s</span><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">Unknown Event: &lt;bb.event.NoProvider=
 instance at 0x9e0ecec&gt;</span><br style=3D"color:rgb(102,102,0)"><span s=
tyle=3D"color:rgb(102,102,0)">NOTE: Runtime target &#39;dpkg&#39; is unbuil=
dable, removing...</span><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">Missing or unbuildable dependency chai=
n was: [&#39;dpkg&#39;]</span><br style=3D"color:rgb(102,102,0)"><span styl=
e=3D"color:rgb(102,102,0)">ERROR: Required build target &#39;devel-image&#3=
9; has no buildable providers.</span><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">Missing or unbuildable dependency chai=
n was: [&#39;devel-image&#39;, &#39;dpkg&#39;]</span><br style=3D"color:rgb=
(102,102,0)"><span style=3D"color:rgb(102,102,0)">Command execution failed:=
 Traceback (most recent call last):</span><br style=3D"color:rgb(102,102,0)=
">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/command.py&quot;, line 88, in runA=
syncCommand</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color:r=
gb(102,102,0)">=A0=A0=A0 commandmethod(self.cmds_async, self, options)</spa=
n><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/command.py&quot;, line 174, in bui=
ldTargets</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color:rgb=
(102,102,0)">=A0=A0=A0 command.cooker.buildTargets(pkgs_to_build, task)</sp=
an><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/cooker.py&quot;, line 784, in buil=
dTargets</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color:rgb(=
102,102,0)">=A0=A0=A0 taskdata.add_unresolved(localdata, self.status)</span=
><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py&quot;, line 562, in ad=
d_unresolved</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color:=
rgb(102,102,0)">=A0=A0=A0 self.remove_runtarget(self.getrun_id(target))</sp=
an><br style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py&quot;, line 535, in re=
move_runtarget</span><br style=3D"color:rgb(102,102,0)"><span style=3D"colo=
r:rgb(102,102,0)">=A0=A0=A0 self.fail_fnid(fnid, missing_list)</span><br st=
yle=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py&quot;, line 490, in fa=
il_fnid</span><br style=3D"color:rgb(102,102,0)"><span style=3D"color:rgb(1=
02,102,0)">=A0=A0=A0 self.remove_buildtarget(target, missing_list)</span><b=
r style=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">=A0 File &quot;/media/325GB_Drive/fs_d=
ev/p2020_20110709/scripts/bitbake/lib/bb/taskdata.py&quot;, line 519, in re=
move_buildtarget</span><br style=3D"color:rgb(102,102,0)"><span style=3D"co=
lor:rgb(102,102,0)">=A0=A0=A0 raise bb.providers.NoProvider</span><br style=
=3D"color:rgb(102,102,0)">
<span style=3D"color:rgb(102,102,0)">NoProvider</span></font><br><br><br>Wh=
ere I should provide the configurations/specification for source...<br></b>=
<br><br><br><br>Reg,<br>Gopi Krishnan S<br>

--0015175df216f105aa04bfbd17d4--
