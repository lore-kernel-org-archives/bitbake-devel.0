Return-Path: <rehsack@gmail.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id 8037760190
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 17:18:21 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id z4-v6so13476985wrb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 01 Oct 2018 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
	:references; bh=0ewtGjf+eaioNkgcAskg0zETuHd0m9FsEXnjuoEbjmA=;
	b=ChFb71XGVks2fHlrQCg1cRU4OhJ9bHJwCnS5C/ZU0h76/F339dRjovzD9Qli75/lXP
	LWDbaQjsxhKNgtW4Con/WvDp4TElshs1DN/7PAMHidF2F/vhNEegj677ewwZwnold/iY
	4/aqwkvOXMB9g1L8dp1vFNXTzOG7+38DgBvCvCu/vF+RK/yIX8bjzJgOJbUu/HFM73VA
	wTPuBX9PN82HQHwu0crGoo+dOH0UI1zT4I3HRvXvHvOj9Fxfophd2e5dpeUzCWmi2Gvd
	MxipjAIjbT1dJuyh6Zawz5zHBVNhce++DzHuzP31/c7ig7cfnUFww8QllyQCGmyVve1f
	vB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:mime-version:subject:date
	:in-reply-to:cc:to:references;
	bh=0ewtGjf+eaioNkgcAskg0zETuHd0m9FsEXnjuoEbjmA=;
	b=jURaMbsr9bT6hfB2LfvmsV3vkHch/F1HT+v6NeEUE9Z5bIGbF2uIRzqjzxt7UQcC1N
	VGL4OkXuhYiwi9K/mtxdhWrHv403OsMsDY6PRANm99bpS+j3152ooafLy8heFRAdVD86
	WGu2Kbq8VOGFgmeMryXAikn/h8EV1zAMpObb7MkMk0TSBvSwedF8XNVKrsa6f2/4udhx
	nNNHTlLHfqg83TR1gPy5PDuHJZdsrwJQywz0rGIzYhWbbgMNkA2/MoXdl8OoBo8l6ID7
	U3aeZuz9nqTlzzNseylVvE2d00NLR7Ana7GPKYpyOzvb1xzWaTrqQrFvH7yNXXVMAoqb
	Z2Dg==
X-Gm-Message-State: ABuFfogP4vB8Jv5JWJWKeA9YapdZ/EwkTMKEHnHWXewy5x9/OLyGb4tm
	ZGITD5JKBkgdLuIS8Y7p5gI=
X-Google-Smtp-Source: ACcGV6366WpSZXC0ibrCI6gDLE0G8tk5qbY6qCCNnhMswAy8tZV8jVCBi7/fdN/Zovs8vOB6iZeqKw==
X-Received: by 2002:adf:b2d7:: with SMTP id
	g81-v6mr8181186wrd.48.1538414302082; 
	Mon, 01 Oct 2018 10:18:22 -0700 (PDT)
Received: from ernie.muppets.liwing.de (b2b-78-94-80-58.unitymedia.biz.
	[78.94.80.58]) by smtp.gmail.com with ESMTPSA id
	l125-v6sm12869609wmb.1.2018.10.01.10.18.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Oct 2018 10:18:21 -0700 (PDT)
From: Jens Rehsack <rehsack@gmail.com>
Message-Id: <DD5B4CCF-37DA-43D8-8148-1F4E3F2E3BF2@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 1 Oct 2018 19:18:19 +0200
In-Reply-To: <340666ae-b209-335d-69e7-641b31dc14a0@windriver.com>
To: Mark Hatle <mark.hatle@windriver.com>
References: <E7ABEDBFC1D25948BA30B74A3925A78C6093F6A6@MgeExchMbx1.miltenyibiotec.de>
	<340666ae-b209-335d-69e7-641b31dc14a0@windriver.com>
X-Mailer: Apple Mail (2.3445.9.1)
Cc: Volker Mink <VolkerMi@miltenyibiotec.de>,
	Burghard Bode | External Miltenyi Biotec
	<burghardb@external.miltenyibiotec.de>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Jens Rehsack | External Miltenyi Biotec <jensr@external.miltenyibiotec.de>
Subject: Re: gitsm Fetcher update
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
X-List-Received-Date: Mon, 01 Oct 2018 17:18:21 -0000
X-Groupsio-MsgNum: 9628
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B1D8F9D4-5160-467D-B23F-63308CC54AE9";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_B1D8F9D4-5160-467D-B23F-63308CC54AE9
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_7BAE5128-03C4-437A-AA8A-C56A3D7C8515"

--Apple-Mail=_7BAE5128-03C4-437A-AA8A-C56A3D7C8515
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Am 01.10.2018 um 15:34 schrieb Mark Hatle <mark.hatle@windriver.com>:
>=20
> On 10/1/18 3:52 AM, Jens Rehsack | External Miltenyi Biotec wrote:
>> Hi Mark,
>>=20
>> after your last update to gitsm fetcher, it seems it cannot handle =
submodules not using the master branch correctly:
>=20
> I'm not sure I understand below what is going wrong.
>=20
> Does it not checkout the primary repository in the correct branch, or =
does this
> get checked out -- and it's the submodules that get 'confused' between =
the
> pointed to commit and the branches?

The primary repository is - as far as I can see from the logs - checked =
out correctly.
It just tries to apply the branch 'master' to the submodule. The primary =
repository has
the branch 'develop' - what makes me a bit curios.

> The system recursively processes the git submodules, while =
interrogating it's
> way through the system.  If the failure is on a submode (not the main
> repository) it would be something in this block...
>=20
> http://git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py
>=20
> 47 - 108
>=20
> Looking at the code, line 81.
>=20
>            # Build new SRC_URI
>            proto =3D uris[module].split(':', 1)[0]
>            url =3D uris[module].replace('%s:' % proto, 'gitsm:', 1)
>            url +=3D ';protocol=3D%s' % proto
>            url +=3D ";name=3D%s" % module
>            url +=3D ";qbareclone=3D1;nocheckout=3D1"
>=20
>=20
> It looks like a 'q' accidentally made it into the patch.  Can you =
remove this
> and try it?   This is where the system constructs SRC_URI for the =
recursive
> (submodule) download.  The next block defines the SRCREV and related =
items and
> re-calls fetch.

Will do tomorrow when I'm back in company and report back.

> Nowhere in there do we call or set anything related to the branches.  =
Maybe
> "nobranch=3D1" needs to be added to the generated SRC_URI?

I tried that and this ended up in wrong names for the archive files =
created
for the download cache (see below).

> If you can give me a recipe that used to work through 'do_unpack', =
then I should
> be able to attempt to replicate it locally and work through the =
problems if the
> above isn't enough of a place to look.

Unfortunately we have only proprietary recipes using that. I can try =
create
one for a perl module I maintain, if you like.
You will need meta-cpan for that - can you confirm that meta-cpan works
for you in general (https://github.com/meta-cpan =
<https://github.com/meta-cpan>)?

> (It also shows a missing test case, one that we need to add -- once we
> understand what part and why it's failing.)
>=20
> --Mark

Best regards,
Jens

>> --- BEGIN INITIAL ERROR
>> WARNING: automacs-ui-git-r0 do_fetch: Failed to fetch URL =
gitsm://mgegit.miltenyibiotec.de:7999/umsa/automacs-ui.git;protocol=3Dssh;=
branch=3Ddevelop;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8, =
attempting MIRRORS if available
>> ERROR: automacs-ui-git-r0 do_fetch: Fetcher failure for URL: =
'gitsm://git@mgegit.miltenyibiotec.de:7999/cpsm/cmake-modules.git;protocol=
=3Dssh;name=3Dcmake/modules;qbareclone=3D1;nocheckout=3D1'. Unable to =
fetch URL from any source.
>> ERROR: automacs-ui-git-r0 do_fetch: Fetcher failure for URL: =
'gitsm://mgegit.miltenyibiotec.de:7999/umsa/automacs-ui.git;protocol=3Dssh=
;branch=3Ddevelop;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8'. =
Unable to fetch URL from any source.
>> ERROR: automacs-ui-git-r0 do_fetch: Function failed: base_do_fetch
>> ERROR: Logfile of failure stored in: =
/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/temp/log.do_fetch.5452
>> ERROR: Task =
(/home/sno/gpw-community-bsp/sources/meta-miltenyi/recipes-ui/automacs-ui/=
automacs-ui_git.bb:do_fetch) failed with exit code '1'
>>=20
>> DEBUG: Running export PSEUDO_DISABLED=3D1; export =
GIT_PROXY_COMMAND=3D"oe-git-proxy"; export =
NO_PROXY=3D"*.miltenyibiotec.de,*.miltenyibiotec.com"; export =
https_proxy=3D"http://proxy2:8080/"; export =
http_proxy=3D"http://proxy2:8080/"; export =
PATH=3D"/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/sysroots-unina=
tive/x86_64-linux/usr/bin:/home/sno/gpw-community-bsp/sources/poky/scripts=
:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-li=
nux/automacs-ui/git-r0/recipe-sysroot-native/usr/bin/x86_64-poky-linux:/ho=
me/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/=
automacs-ui/git-r0/recipe-sysroot/opt/miltenyi/bin/crossscripts:/home/sno/=
gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/automac=
s-ui/git-r0/recipe-sysroot-native/usr/sbin:/home/sno/gpw-community-bsp/mop=
s-yocto-platform/tmp/work/core2-64-poky-linux/automacs-ui/git-r0/recipe-sy=
sroot-native/usr/bin:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/w=
ork/core2-64-poky-linux/automacs-ui/git-r0/recipe-sysroot-native/sbin:/hom=
e/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/a=
utomacs-ui/git-r0/recipe-sysroot-native/bin:/home/sno/gpw-community-bsp/so=
urces/poky/bitbake/bin:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp=
/hosttools"; export HOME=3D"/home/sno"; git -c core.fsyncobjectfiles=3D0 =
branch --contains c6c052603e2e3ea334c5a71e3584855c5535995f --list master =
2> /dev/null | wc -l
>> --- END INITIAL ERROR
>>=20
>> I cloned the appropriate project locally to see what's going on:
>>=20
>> sno@yoctopoc:~/prj/automacs-ui/cmake/modules$ git -c =
core.fsyncobjectfiles=3D0 branch --contains =
c6c052603e2e3ea334c5a71e3584855c5535995f --list
>> * (HEAD detached at c6c0526)
>>  develop
>> sno@yoctopoc:~/prj/automacs-ui/cmake/modules$ git -c =
core.fsyncobjectfiles=3D0 branch --contains =
c6c052603e2e3ea334c5a71e3584855c5535995f --list master
>> sno@yoctopoc:~/prj/automacs-ui/cmake/modules$
>>=20
>> The I tried to reverse engineer the gitsm fetcher and added:
>>=20
>> poky$ git diff
>> diff --git a/bitbake/lib/bb/fetch2/gitsm.py =
b/bitbake/lib/bb/fetch2/gitsm.py
>> index 51f8d0e68c..221af934c3 100644
>> --- a/bitbake/lib/bb/fetch2/gitsm.py
>> +++ b/bitbake/lib/bb/fetch2/gitsm.py
>> @@ -79,6 +79,7 @@ class GitSM(Git):
>>             url +=3D ';protocol=3D%s' % proto
>>             url +=3D ";name=3D%s" % module
>>             url +=3D ";qbareclone=3D1;nocheckout=3D1"
>> +            url +=3D ";nobranch=3D1"
>>=20
>>             ld =3D d.createCopy()
>>             # Not necessary to set SRC_URI, since we're passing the =
URI to
>>=20
>> which results into
>>=20
>> --- BEGIN FOLLOW UP ERROR
>> ERROR: automacs-ui-git-r0 do_unpack: Fetcher failure: Submodule =
cmake/modules does not exist in =
/home/sno/gpw-community-bsp/mops-yocto-platform/downloads/git2/mgegit.milt=
enyibiotec.de.7999.umsa.automacs-ui.git/modules/cmake/modules or =
/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/git/.git/modules/cmake/modules.
>> ERROR: automacs-ui-git-r0 do_unpack: Function failed: base_do_unpack
>> ERROR: Logfile of failure stored in: =
/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/temp/log.do_unpack.6551
>> ERROR: Task =
(/home/sno/gpw-community-bsp/sources/meta-miltenyi/recipes-ui/automacs-ui/=
automacs-ui_git.bb:do_unpack) failed with exit code '1'
>> --- END FOLLOW UP ERROR
>>=20
>> because it uses the submodule names as archive name:
>>=20
>> $ tar xzf downloads/git2_mgegit.miltenyibiotec.de.7999.<TAB>
>> git2_mgegit.miltenyibiotec.de.7999.cpsm.cmake-modules.git.tar.gz
>> git2_mgegit.miltenyibiotec.de.7999.cpsm.mcs-lib.git.tar.gz
>> git2_mgegit.miltenyibiotec.de.7999.umsa.corert.git.tar.gz
>> git2_mgegit.miltenyibiotec.de.7999.umsa.protos.git.tar.gz
>>=20
>> Cheers,
>> Jens
>>=20
>=20

--
Jens Rehsack - rehsack@gmail.com


--Apple-Mail=_7BAE5128-03C4-437A-AA8A-C56A3D7C8515
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">Am 01.10.2018 um 15:34 schrieb Mark Hatle &lt;<a =
href=3D"mailto:mark.hatle@windriver.com" =
class=3D"">mark.hatle@windriver.com</a>&gt;:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">On =
10/1/18 3:52 AM, Jens Rehsack | External Miltenyi Biotec wrote:<br =
class=3D""><blockquote type=3D"cite" class=3D"">Hi Mark,<br class=3D""><br=
 class=3D"">after your last update to gitsm fetcher, it seems it cannot =
handle submodules not using the master branch correctly:<br =
class=3D""></blockquote><br class=3D"">I'm not sure I understand below =
what is going wrong.<br class=3D""><br class=3D"">Does it not checkout =
the primary repository in the correct branch, or does this<br =
class=3D"">get checked out -- and it's the submodules that get =
'confused' between the<br class=3D"">pointed to commit and the =
branches?<br class=3D""></div></div></blockquote><div><br =
class=3D""></div><div>The primary repository is - as far as I can see =
from the logs - checked out correctly.</div><div>It just tries to apply =
the branch 'master' to the submodule. The primary repository =
has</div><div>the branch 'develop' - what makes me a bit =
curios.</div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><div class=3D"">The system recursively processes the git =
submodules, while interrogating it's<br class=3D"">way through the =
system. &nbsp;If the failure is on a submode (not the main<br =
class=3D"">repository) it would be something in this block...<br =
class=3D""><br class=3D""><a =
href=3D"http://git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py" =
class=3D"">http://git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py=
</a><br class=3D""><br class=3D"">47 - 108<br class=3D""><br =
class=3D"">Looking at the code, line 81.<br class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# =
Build new SRC_URI<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;proto =
=3D uris[module].split(':', 1)[0]<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;url =3D =
uris[module].replace('%s:' % proto, 'gitsm:', 1)<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;url +=3D=
 ';protocol=3D%s' % proto<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;url +=3D=
 ";name=3D%s" % module<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;url +=3D=
 ";qbareclone=3D1;nocheckout=3D1"<br class=3D""><br class=3D""><br =
class=3D"">It looks like a 'q' accidentally made it into the patch. =
&nbsp;Can you remove this<br class=3D"">and try it? &nbsp;&nbsp;This is =
where the system constructs SRC_URI for the recursive<br =
class=3D"">(submodule) download. &nbsp;The next block defines the SRCREV =
and related items and<br class=3D"">re-calls fetch.<br =
class=3D""></div></div></blockquote><div><br class=3D""></div><div>Will =
do tomorrow when I'm back in company and report back.</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><div =
class=3D"">Nowhere in there do we call or set anything related to the =
branches. &nbsp;Maybe<br class=3D"">"nobranch=3D1" needs to be added to =
the generated SRC_URI?<br class=3D""></div></div></blockquote><div><br =
class=3D""></div><div>I tried that and this ended up in wrong names for =
the archive files created</div><div>for the download cache (see =
below).</div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><div class=3D"">If you can give me a recipe that used to work =
through 'do_unpack', then I should<br class=3D"">be able to attempt to =
replicate it locally and work through the problems if the<br =
class=3D"">above isn't enough of a place to look.<br =
class=3D""></div></div></blockquote><div><br =
class=3D""></div><div>Unfortunately we have only proprietary recipes =
using that. I can try create</div><div>one for a perl module I maintain, =
if you like.</div><div>You will need meta-cpan for that - can you =
confirm that meta-cpan works</div><div>for you in general (<a =
href=3D"https://github.com/meta-cpan" =
class=3D"">https://github.com/meta-cpan</a>)?</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><div =
class=3D"">(It also shows a missing test case, one that we need to add =
-- once we<br class=3D"">understand what part and why it's failing.)<br =
class=3D""><br class=3D"">--Mark<br =
class=3D""></div></div></blockquote><div><br class=3D""></div><div>Best =
regards,</div><div>Jens</div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D""><div class=3D""><blockquote type=3D"cite" =
class=3D"">--- BEGIN INITIAL ERROR<br class=3D"">WARNING: =
automacs-ui-git-r0 do_fetch: Failed to fetch URL <a =
href=3D"gitsm://mgegit.miltenyibiotec.de:7999/umsa/automacs-ui.git;protoco=
l=3Dssh;branch=3Ddevelop;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8" =
class=3D"">gitsm://mgegit.miltenyibiotec.de:7999/umsa/automacs-ui.git;prot=
ocol=3Dssh;branch=3Ddevelop;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8=
</a>, attempting MIRRORS if available<br class=3D"">ERROR: =
automacs-ui-git-r0 do_fetch: Fetcher failure for URL: '<a =
href=3D"gitsm://git@mgegit.miltenyibiotec.de:7999/cpsm/cmake-modules.git;p=
rotocol=3Dssh;name=3Dcmake/modules;qbareclone=3D1;nocheckout=3D1" =
class=3D"">gitsm://git@mgegit.miltenyibiotec.de:7999/cpsm/cmake-modules.gi=
t;protocol=3Dssh;name=3Dcmake/modules;qbareclone=3D1;nocheckout=3D1</a>'. =
Unable to fetch URL from any source.<br class=3D"">ERROR: =
automacs-ui-git-r0 do_fetch: Fetcher failure for URL: '<a =
href=3D"gitsm://mgegit.miltenyibiotec.de:7999/umsa/automacs-ui.git;protoco=
l=3Dssh;branch=3Ddevelop;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8" =
class=3D"">gitsm://mgegit.miltenyibiotec.de:7999/umsa/automacs-ui.git;prot=
ocol=3Dssh;branch=3Ddevelop;rev=3Dfddb26a33d3f949d0863cffc5306146ab8e5a9a8=
</a>'. Unable to fetch URL from any source.<br class=3D"">ERROR: =
automacs-ui-git-r0 do_fetch: Function failed: base_do_fetch<br =
class=3D"">ERROR: Logfile of failure stored in: =
/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/temp/log.do_fetch.5452<br class=3D"">ERROR: Task =
(/home/sno/gpw-community-bsp/sources/meta-miltenyi/recipes-ui/automacs-ui/=
automacs-ui_git.bb:do_fetch) failed with exit code '1'<br class=3D""><br =
class=3D"">DEBUG: Running export PSEUDO_DISABLED=3D1; export =
GIT_PROXY_COMMAND=3D"oe-git-proxy"; export NO_PROXY=3D"*.<a =
href=3D"http://miltenyibiotec.de" class=3D"">miltenyibiotec.de</a>,*.<a =
href=3D"http://miltenyibiotec.com" class=3D"">miltenyibiotec.com</a>"; =
export https_proxy=3D"<a href=3D"http://proxy2:8080/" =
class=3D"">http://proxy2:8080/</a>"; export http_proxy=3D"<a =
href=3D"http://proxy2:8080/" class=3D"">http://proxy2:8080/</a>"; export =
PATH=3D"/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/sysroots-unina=
tive/x86_64-linux/usr/bin:/home/sno/gpw-community-bsp/sources/poky/scripts=
:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-li=
nux/automacs-ui/git-r0/recipe-sysroot-native/usr/bin/x86_64-poky-linux:/ho=
me/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/=
automacs-ui/git-r0/recipe-sysroot/opt/miltenyi/bin/crossscripts:/home/sno/=
gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/automac=
s-ui/git-r0/recipe-sysroot-native/usr/sbin:/home/sno/gpw-community-bsp/mop=
s-yocto-platform/tmp/work/core2-64-poky-linux/automacs-ui/git-r0/recipe-sy=
sroot-native/usr/bin:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/w=
ork/core2-64-poky-linux/automacs-ui/git-r0/recipe-sysroot-native/sbin:/hom=
e/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-linux/a=
utomacs-ui/git-r0/recipe-sysroot-native/bin:/home/sno/gpw-community-bsp/so=
urces/poky/bitbake/bin:/home/sno/gpw-community-bsp/mops-yocto-platform/tmp=
/hosttools"; export HOME=3D"/home/sno"; git -c core.fsyncobjectfiles=3D0 =
branch --contains c6c052603e2e3ea334c5a71e3584855c5535995f --list master =
2&gt; /dev/null | wc -l<br class=3D"">--- END INITIAL ERROR<br =
class=3D""><br class=3D"">I cloned the appropriate project locally to =
see what's going on:<br class=3D""><br =
class=3D"">sno@yoctopoc:~/prj/automacs-ui/cmake/modules$ git -c =
core.fsyncobjectfiles=3D0 branch --contains =
c6c052603e2e3ea334c5a71e3584855c5535995f --list<br class=3D"">* (HEAD =
detached at c6c0526)<br class=3D""> &nbsp;develop<br =
class=3D"">sno@yoctopoc:~/prj/automacs-ui/cmake/modules$ git -c =
core.fsyncobjectfiles=3D0 branch --contains =
c6c052603e2e3ea334c5a71e3584855c5535995f --list master<br =
class=3D"">sno@yoctopoc:~/prj/automacs-ui/cmake/modules$<br class=3D""><br=
 class=3D"">The I tried to reverse engineer the gitsm fetcher and =
added:<br class=3D""><br class=3D"">poky$ git diff<br class=3D"">diff =
--git a/bitbake/lib/bb/fetch2/gitsm.py =
b/bitbake/lib/bb/fetch2/gitsm.py<br class=3D"">index =
51f8d0e68c..221af934c3 100644<br class=3D"">--- =
a/bitbake/lib/bb/fetch2/gitsm.py<br class=3D"">+++ =
b/bitbake/lib/bb/fetch2/gitsm.py<br class=3D"">@@ -79,6 +79,7 @@ class =
GitSM(Git):<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ur=
l +=3D ';protocol=3D%s' % proto<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ur=
l +=3D ";name=3D%s" % module<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ur=
l +=3D ";qbareclone=3D1;nocheckout=3D1"<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;url +=3D=
 ";nobranch=3D1"<br class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ld=
 =3D d.createCopy()<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# =
Not necessary to set SRC_URI, since we're passing the URI to<br =
class=3D""><br class=3D"">which results into <br class=3D""><br =
class=3D"">--- BEGIN FOLLOW UP ERROR<br class=3D"">ERROR: =
automacs-ui-git-r0 do_unpack: Fetcher failure: Submodule cmake/modules =
does not exist in =
/home/sno/gpw-community-bsp/mops-yocto-platform/downloads/git2/<a =
href=3D"http://mgegit.miltenyibiotec.de" =
class=3D"">mgegit.miltenyibiotec.de</a>.7999.umsa.automacs-ui.git/modules/=
cmake/modules or =
/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/git/.git/modules/cmake/modules.<br class=3D"">ERROR:=
 automacs-ui-git-r0 do_unpack: Function failed: base_do_unpack<br =
class=3D"">ERROR: Logfile of failure stored in: =
/home/sno/gpw-community-bsp/mops-yocto-platform/tmp/work/core2-64-poky-lin=
ux/automacs-ui/git-r0/temp/log.do_unpack.6551<br class=3D"">ERROR: Task =
(/home/sno/gpw-community-bsp/sources/meta-miltenyi/recipes-ui/automacs-ui/=
automacs-ui_git.bb:do_unpack) failed with exit code '1'<br class=3D"">--- =
END FOLLOW UP ERROR<br class=3D""><br class=3D"">because it uses the =
submodule names as archive name:<br class=3D""><br class=3D"">$ tar xzf =
downloads/<a href=3D"http://git2_mgegit.miltenyibiotec.de" =
class=3D"">git2_mgegit.miltenyibiotec.de</a>.7999.&lt;TAB&gt;<br =
class=3D""><a href=3D"http://git2_mgegit.miltenyibiotec.de" =
class=3D"">git2_mgegit.miltenyibiotec.de</a>.7999.cpsm.cmake-modules.git.t=
ar.gz<br class=3D""><a href=3D"http://git2_mgegit.miltenyibiotec.de" =
class=3D"">git2_mgegit.miltenyibiotec.de</a>.7999.cpsm.mcs-lib.git.tar.gz<=
br class=3D""><a href=3D"http://git2_mgegit.miltenyibiotec.de" =
class=3D"">git2_mgegit.miltenyibiotec.de</a>.7999.umsa.corert.git.tar.gz<b=
r class=3D""><a href=3D"http://git2_mgegit.miltenyibiotec.de" =
class=3D"">git2_mgegit.miltenyibiotec.de</a>.7999.umsa.protos.git.tar.gz<b=
r class=3D""><br class=3D"">Cheers,<br class=3D"">Jens<br class=3D""><br =
class=3D""></blockquote><br class=3D""></div></div></blockquote></div><br =
class=3D""><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">--&nbsp;</div><div class=3D"">Jens Rehsack - =
<a href=3D"mailto:rehsack@gmail.com" =
class=3D"">rehsack@gmail.com</a></div></div></div>
</div>
<br class=3D""></body></html>=

--Apple-Mail=_7BAE5128-03C4-437A-AA8A-C56A3D7C8515--

--Apple-Mail=_B1D8F9D4-5160-467D-B23F-63308CC54AE9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEGutaqWUYV+tvC/mCRJmWrtzlCp0FAluyVtsACgkQRJmWrtzl
Cp0ZzhAAsGQ6bIN1jnkreFbCGVPQW8TFKzjZLdy4rfWAETS5Y5aoCTfwjCx9YYYJ
4wMCFHS4DZdp4/kTnz3lGtl1xWGecootHhrW9ij1pxQZN4g7tP1QYQmnN1zuwkI+
eRtCtuuGq9uwV4bxmQTdoJuhGtwz4v4hQY5iIzw7vJ7++oS2sGDZ3iEh13SRdbsJ
iLwNKcj8Xz7qUKE+U8u6xQUZRg1AOxKWmct9gH6mJhiP0Er6hnmloflWHWvR3vTb
E6bUcMn3P68ys8UjjI7arf7VDT3naJIh1tlBljDg9tm3yKAFXCeixT7Al6ZJUl+T
CYCTW32x+brtho9QR6k0MAUQOpSAnjhaDyqL/2bjKQISedE4xXn/8xCWJowaFJPP
jJymB+SPvS3Pa8D+oPhnGmrzypZ8HCRB1xQ6O9VKKKzvR3V7XaiMC24JetFNf6BO
K/CGmO+QRLvTJygez4AdbfX/Y/Nr8k3PDrZePs/t9ZpL0PBXvnao1WZ7bFnGxJN6
UPVC+BCeplqSw2/l2maWkjxBahcOHS6Ljda68TZoCOYa63dix3LGkt9zJlAQZybP
mbwa33zeM3meIz14QF547Ub0mNMd3ipd3ubfF4o5ppV+ZwG4zU0uJ4FKFB/fwrLN
uB5G+GUVQICG/PWdRnuvqWnTl5qfkJcV4RLvUB3lU9SM0VIMThE=
=aiQL
-----END PGP SIGNATURE-----

--Apple-Mail=_B1D8F9D4-5160-467D-B23F-63308CC54AE9--
