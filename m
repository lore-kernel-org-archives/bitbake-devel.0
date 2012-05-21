Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <francesco.brundu@gmail.com>) id 1SWXIC-0005Ph-NB
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 20:25:17 +0200
Received: by obhx4 with SMTP id x4so9405656obh.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=s+jhAHjYP5Lyug+PJJf4HOzfLJ4R1D00/dVShX4gJk8=;
	b=zDvvReIKx6oIPANTjkErcEQvRd1A+gxQCo8GyiqwoUDUCbkJB4VluMcqDelIqAU5sv
	IkwQTflaU+Jw0CV5/WOpn4gfhdL3wwQSRqjoeFcXy7tWGpRuLvyuJF0G8A9Umev2X3gv
	bkQ/6BZ/GOOIfvGg6M+wI99A7n5o+ThvULsa6I2Ia2neQMFDkd4oWATttploVenIsbFv
	D/rsAe63FMvCuJY9Q+SL9I+khBOuxSfnAx07sNSeTWQih5gsTP0V7MVM/gHG+IhX9rg0
	wHhF/H2m1P08k9NrWJR/5m8D9wrbdBINfWLRWo1/EQxeEFXEQ//B9A7/x6rf9JBF7zT7
	8+FQ==
MIME-Version: 1.0
Received: by 10.182.13.8 with SMTP id d8mr19822845obc.36.1337624108088; Mon,
	21 May 2012 11:15:08 -0700 (PDT)
Received: by 10.60.69.162 with HTTP; Mon, 21 May 2012 11:15:07 -0700 (PDT)
In-Reply-To: <CABcZAN=ur8sRo3FW3o9FUwdG1Ceu+=hsyQuEcLnF-8MgtU7-Rg@mail.gmail.com>
References: <CAFc_i-FgKp-Gwr9GEs3ApjTE8vvwU=u7abOA1KwWRtEXpoV3cA@mail.gmail.com>
	<CABcZAN=ur8sRo3FW3o9FUwdG1Ceu+=hsyQuEcLnF-8MgtU7-Rg@mail.gmail.com>
Date: Mon, 21 May 2012 20:15:07 +0200
Message-ID: <CAFc_i-HzOPOde1=J0iXa5MoFJFhJjBn0JKV4meOgXfNkV=iV2g@mail.gmail.com>
From: "francesco.brundu@gmail.com" <francesco.brundu@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake raises MultipleMatches exception while trying to build uclibc
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
X-List-Received-Date: Mon, 21 May 2012 18:25:17 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ok thanks. Bitbake now gives me "No provider Error" for uclibc

user@ubuntu:~/stuff$ bitbake uclibc
Loading cache: 100%
|##########################################################################=
###########################################################################=
#########################################|
Time: 00:00:02
Loaded 7102 entries from dependency cache.
Parsing recipes: 100%
|##########################################################################=
###########################################################################=
#######################################|
Time: 00:00:04
Parsing of 7217 .bb files complete (6456 cached, 761 parsed). 7886
targets, 310 skipped, 0 masked, 0 errors.

Build Configuration:
BB_VERSION        =3D "1.12.0"
METADATA_BRANCH   =3D "master"
METADATA_REVISION =3D "1ff63aa"
TARGET_ARCH       =3D "arm"
TARGET_OS         =3D "linux-gnueabi"
MACHINE           =3D "beagleboard"
DISTRO            =3D "angstrom"
DISTRO_VERSION    =3D "v2012.05"
TARGET_FPU        =3D "hard"

ERROR: Nothing PROVIDES 'uclibc'
ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
runAsyncCommand
    commandmethod(self.cmds_async, self, options)
  File "/home/user/stuff/bitbake/lib/bb/command.py", line 200, in buildTarg=
ets
    command.cooker.buildTargets(pkgs_to_build, task)
  File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 730, in buildTarge=
ts
    taskdata.add_provider(localdata, self.status, k)
  File "/home/user/stuff/bitbake/lib/bb/taskdata.py", line 353, in add_prov=
ider
    self.add_provider_internal(cfgData, dataCache, item)
  File "/home/user/stuff/bitbake/lib/bb/taskdata.py", line 373, in
add_provider_internal
    raise bb.providers.NoProvider(item)
NoProvider: uclibc

but there are recipes for uclibc if provider means recipe; there is a
directory uclibc under openembedded/recipes with following files:

-rw-rw-r--  1 user user  1103 May 11 15:39 bfin-uclibc_svn.bb
-rw-rw-r--  1 user user   475 May 11 15:39 elf2flt_svn.bb
drwxrwxr-x  2 user user  4096 May 11 15:39 files
drwxrwxr-x 15 user user  4096 May 11 15:39 uclibc-0.9.28
-rw-rw-r--  1 user user  3205 May 11 15:39 uclibc_0.9.28.bb
drwxrwxr-x 43 user user 12288 May 11 15:39 uclibc-0.9.29
-rw-rw-r--  1 user user  1774 May 11 15:39 uclibc_0.9.29.bb
drwxrwxr-x 45 user user 12288 May 11 15:39 uclibc-0.9.30
drwxrwxr-x 48 user user 12288 May 11 15:39 uclibc-0.9.30.1
-rw-rw-r--  1 user user  1519 May 11 15:39 uclibc_0.9.30.1.bb
drwxrwxr-x 48 user user 12288 May 11 15:39 uclibc-0.9.30.2
-rw-rw-r--  1 user user  1293 May 11 15:39 uclibc_0.9.30.2.bb
drwxrwxr-x 48 user user 12288 May 11 15:39 uclibc-0.9.30.3
-rw-rw-r--  1 user user  1137 May 11 15:39 uclibc_0.9.30.3.bb
-rw-rw-r--  1 user user  1401 May 11 15:39 uclibc_0.9.30.bb
drwxrwxr-x 48 user user 12288 May 11 15:39 uclibc-0.9.31
-rw-rw-r--  1 user user  1131 May 11 15:39 uclibc_0.9.31.bb
-rw-rw-r--  1 user user  3663 May 11 15:39 uclibc-config.inc
drwxrwxr-x 21 user user  4096 May 11 15:39 uclibc-git
-rw-rw-r--  1 user user  1822 May 11 15:39 uclibc_git.bb
-rw-rw-r--  1 user user  8090 May 11 15:39 uclibc.inc
-rw-rw-r--  1 user user  1002 May 11 15:39 uclibc-initial_0.9.28.bb
-rw-rw-r--  1 user user   833 May 11 15:39 uclibc-initial_0.9.29.bb
-rw-rw-r--  1 user user   818 May 11 15:39 uclibc-initial_0.9.30.1.bb
-rw-rw-r--  1 user user   589 May 11 15:39 uclibc-initial_0.9.30.2.bb
-rw-rw-r--  1 user user   818 May 11 15:39 uclibc-initial_0.9.30.3.bb
-rw-rw-r--  1 user user   662 May 11 15:39 uclibc-initial_0.9.30.bb
-rw-rw-r--  1 user user   818 May 11 15:39 uclibc-initial_0.9.31.bb
-rw-rw-r--  1 user user   582 May 11 15:39 uclibc-initial_git.bb
-rw-rw-r--  1 user user  7216 May 11 15:39 uclibc-old.inc

I tried with uclibc, uclibc-initial and uclibc-0.9.30.
Thanks

On 21 May 2012 18:26, Chris Larson <clarson@kergoth.com> wrote:
> On Mon, May 21, 2012 at 9:12 AM, francesco.brundu@gmail.com
> <francesco.brundu@gmail.com> wrote:
>> I have a problem, hope this is the right place to post. Anyway I am
>> trying to build uclibc for arm7a architecture, via bitbake, but I get
>> the following output:
>>
>> user@ubuntu:~/stuff$ bitbake -b uclibc
>> ERROR: Unable to match uclibc (19 matches found):
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_git.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.30.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.30.2.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/bfin-u=
clibc_svn.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.31.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.30.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.29.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.30.2.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.31.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.29.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_git.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.28.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.30.1.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.30.3.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.28.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc++/ucli=
bc++_git.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/elf2fl=
t_svn.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
-initial_0.9.30.1.bb
>> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc=
_0.9.30.3.bb
>> ERROR: Command execution failed: Traceback (most recent call last):
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
>> runAsyncCommand
>> =C2=A0 =C2=A0commandmethod(self.cmds_async, self, options)
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 190, in bu=
ildFile
>> =C2=A0 =C2=A0command.cooker.buildFile(bfile, task)
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 608, in bui=
ldFile
>> =C2=A0 =C2=A0buildfile =3D self.matchFile(fn)
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 591, in mat=
chFile
>> =C2=A0 =C2=A0raise MultipleMatches
>> MultipleMatches
>>
>> I am trying also to build a specific recipe (Am I doing it wrong?) but I=
 get
>>
>> user@ubuntu:~/stuff$ bitbake -b
>> /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.31.bb
>> ERROR: Command execution failed: Traceback (most recent call last):
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
>> runAsyncCommand
>> =C2=A0 =C2=A0commandmethod(self.cmds_async, self, options)
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 190, in bu=
ildFile
>> =C2=A0 =C2=A0command.cooker.buildFile(bfile, task)
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 618, in bui=
ldFile
>> =C2=A0 =C2=A0self.status.add_from_recipeinfo(vfn, info)
>> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cache.py", line 583, in
>> add_from_recipeinfo
>> =C2=A0 =C2=A0for provide in info.provides:
>> TypeError: 'NoneType' object is not iterable
>>
>> I have searched a lot but I did not find anything. Thanks
>
> Don't use bitbake -b. -b accepts a filename, not a recipe, and
> bypasses all dependencies. Only experts should use this argument, and
> even then it's questionable. If you want to build a recipe, run
> 'bitbake recipename'.
> --
> Christopher Larson



--=20
Francesco Brundu


