Received: from mail-gh0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <francesco.brundu@gmail.com>) id 1SWVNx-0004n4-75
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 18:23:05 +0200
Received: by ghbz2 with SMTP id z2so444033ghb.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=VmpmY8lrGZqd8G8acabNW+zETPFeKjECdM/peX3j1Zk=;
	b=xgfIPabtgcMcdxdYQ7S03sNhM8NNpN6nCZOt77m41Qdjh1twjrVug2VN0T1Lf1FHQA
	yFFrV1EExEOCSDBJoQmdLy1RH9TH69PyJKe+2qPbvM595sgkGa3ZypJdRB5bh062TqHw
	fyl/TCrZnVrlVNIC4adzz0v1YRtbXJKmZHsuwPhmooqesj1lUArxSv447AgwKiBy99HN
	8eR6Jacd0sxah+hZOtxucY4KYAvKx4mcq/CbPzKm7NUQoF2kNYwX2L3rEjFj5lT64BV5
	N1L5Bs+8XiKrJycJFOMEIEN7e8GAqRx6/8pVhlTVGknWX7fmsr/ypxjMNjusNTHrkduO
	Qisw==
MIME-Version: 1.0
Received: by 10.60.172.195 with SMTP id be3mr19992450oec.48.1337616776800;
	Mon, 21 May 2012 09:12:56 -0700 (PDT)
Received: by 10.60.69.162 with HTTP; Mon, 21 May 2012 09:12:56 -0700 (PDT)
Date: Mon, 21 May 2012 18:12:56 +0200
Message-ID: <CAFc_i-FgKp-Gwr9GEs3ApjTE8vvwU=u7abOA1KwWRtEXpoV3cA@mail.gmail.com>
From: "francesco.brundu@gmail.com" <francesco.brundu@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Bitbake raises MultipleMatches exception while trying to build uclibc
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
X-List-Received-Date: Mon, 21 May 2012 16:23:05 -0000
Content-Type: text/plain; charset=UTF-8

Hi all,
I have a problem, hope this is the right place to post. Anyway I am
trying to build uclibc for arm7a architecture, via bitbake, but I get
the following output:

user@ubuntu:~/stuff$ bitbake -b uclibc
ERROR: Unable to match uclibc (19 matches found):
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_git.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.30.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.30.2.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/bfin-uclibc_svn.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.31.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.30.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.29.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.30.2.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.31.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.29.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_git.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.28.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.30.1.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.30.3.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.28.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc++/uclibc++_git.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/elf2flt_svn.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc-initial_0.9.30.1.bb
ERROR:     /home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.30.3.bb
ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
runAsyncCommand
    commandmethod(self.cmds_async, self, options)
  File "/home/user/stuff/bitbake/lib/bb/command.py", line 190, in buildFile
    command.cooker.buildFile(bfile, task)
  File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 608, in buildFile
    buildfile = self.matchFile(fn)
  File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 591, in matchFile
    raise MultipleMatches
MultipleMatches

I am trying also to build a specific recipe (Am I doing it wrong?) but I get

user@ubuntu:~/stuff$ bitbake -b
/home/user/stuff/openembedded/recipes/uclibc/uclibc_0.9.31.bb
ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/user/stuff/bitbake/lib/bb/command.py", line 102, in
runAsyncCommand
    commandmethod(self.cmds_async, self, options)
  File "/home/user/stuff/bitbake/lib/bb/command.py", line 190, in buildFile
    command.cooker.buildFile(bfile, task)
  File "/home/user/stuff/bitbake/lib/bb/cooker.py", line 618, in buildFile
    self.status.add_from_recipeinfo(vfn, info)
  File "/home/user/stuff/bitbake/lib/bb/cache.py", line 583, in
add_from_recipeinfo
    for provide in info.provides:
TypeError: 'NoneType' object is not iterable

I have searched a lot but I did not find anything. Thanks

-- 
Francesco Brundu


