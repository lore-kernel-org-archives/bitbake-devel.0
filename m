Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SWVfj-0005KT-0Q
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 18:41:27 +0200
Received: by wibhm14 with SMTP id hm14so2261703wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=RqgSyC68fvJUSrdK+EYrAS8Uqkc5Q+e677tsDqVDGwI=;
	b=VniZyJyWOzijXiKymwIMAtZDcYvd81tc45dHWfgTpIWpOlp3Ts5xM/ULjIcS75p0l+
	4r3Azr73cZnWQkwjUYKZ3Xv7clH/sIRaM7nJvwm97kHBa9rgbomdlUnYvXb77dcp6icV
	3ENvnznXqWwL+bo2SJrqyMKZcc7k/cNSQJZHMwaSWHafd88uw9d/ezkPSMyGlNC2QIkQ
	y8zF939dgZYRSyLVjXRXaJomqpuHrz/LbvyH5rXtNJda3A1TQxuLKHtEE3qptDqcrBij
	lY5D1ZA60NfTPKfAEaISgH28BKI4kQWdMhBS0VXgt9NCLam/XYXzdXuZiYWZFbfTIlbB
	XZvg==
Received: by 10.180.102.36 with SMTP id fl4mr19447281wib.2.1337617623395; Mon,
	21 May 2012 09:27:03 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Mon, 21 May 2012 09:26:42 -0700 (PDT)
In-Reply-To: <CAFc_i-FgKp-Gwr9GEs3ApjTE8vvwU=u7abOA1KwWRtEXpoV3cA@mail.gmail.com>
References: <CAFc_i-FgKp-Gwr9GEs3ApjTE8vvwU=u7abOA1KwWRtEXpoV3cA@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 21 May 2012 09:26:42 -0700
X-Google-Sender-Auth: KTi8AQtkSWhXqRPfOQgRVDJSxd0
Message-ID: <CABcZAN=ur8sRo3FW3o9FUwdG1Ceu+=hsyQuEcLnF-8MgtU7-Rg@mail.gmail.com>
To: "francesco.brundu@gmail.com" <francesco.brundu@gmail.com>
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
X-List-Received-Date: Mon, 21 May 2012 16:41:27 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 9:12 AM, francesco.brundu@gmail.com
<francesco.brundu@gmail.com> wrote:
> I have a problem, hope this is the right place to post. Anyway I am
> trying to build uclibc for arm7a architecture, via bitbake, but I get
> the following output:
>
> user@ubuntu:~/stuff$ bitbake -b uclibc
> ERROR: Unable to match uclibc (19 matches found):
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_git.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.30.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.30.2.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/bfin-uc=
libc_svn.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.31.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.30.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.29.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.30.2.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.31.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.29.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
git.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.28.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.30.1.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.30.3.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.28.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc++/uclib=
c++_git.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/elf2flt=
_svn.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc-=
initial_0.9.30.1.bb
> ERROR: =C2=A0 =C2=A0 /home/user/stuff/openembedded/recipes/uclibc/uclibc_=
0.9.30.3.bb
> ERROR: Command execution failed: Traceback (most recent call last):
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
> runAsyncCommand
> =C2=A0 =C2=A0commandmethod(self.cmds_async, self, options)
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 190, in bui=
ldFile
> =C2=A0 =C2=A0command.cooker.buildFile(bfile, task)
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 608, in buil=
dFile
> =C2=A0 =C2=A0buildfile =3D self.matchFile(fn)
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 591, in matc=
hFile
> =C2=A0 =C2=A0raise MultipleMatches
> MultipleMatches
>
> I am trying also to build a specific recipe (Am I doing it wrong?) but I =
get
>
> user@ubuntu:~/stuff$ bitbake -b
> /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.31.bb
> ERROR: Command execution failed: Traceback (most recent call last):
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
> runAsyncCommand
> =C2=A0 =C2=A0commandmethod(self.cmds_async, self, options)
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/command.py", line 190, in bui=
ldFile
> =C2=A0 =C2=A0command.cooker.buildFile(bfile, task)
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 618, in buil=
dFile
> =C2=A0 =C2=A0self.status.add_from_recipeinfo(vfn, info)
> =C2=A0File "/home/user/stuff/bitbake/lib/bb/cache.py", line 583, in
> add_from_recipeinfo
> =C2=A0 =C2=A0for provide in info.provides:
> TypeError: 'NoneType' object is not iterable
>
> I have searched a lot but I did not find anything. Thanks

Don't use bitbake -b. -b accepts a filename, not a recipe, and
bypasses all dependencies. Only experts should use this argument, and
even then it's questionable. If you want to build a recipe, run
'bitbake recipename'.
--=20
Christopher Larson


