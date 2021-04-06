Received: from avasout03.plus.net (avasout03.plus.net [84.93.230.244])
 by mx.groups.io with SMTP id smtpd.web09.22.1617720476014684367
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 07:47:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=qpJ8TZlT;
 spf=pass (domain: mcrowe.com, ip: 84.93.230.244, mailfrom: mac@mcrowe.com)
Received: from deneb.mcrowe.com ([80.229.24.9])
	by smtp with ESMTP
	id TmzYlrTjOutR5TmzZlBz1o; Tue, 06 Apr 2021 15:47:54 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=KZJJTTQD c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=8nJEP1OIZ-IA:10 a=3YhXtTcJ-WEA:10 a=Q4-j1AaZAAAA:8 a=vKhG7OXEa5ScEUDNqAwA:9
 a=wPNLvfGTeEIA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	 s=20191005; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=0aTwk9Jj+rojuALJg1Kd6u1bjUVp6VEf+HQf8l73lyc=; b=qpJ8TZlTLUhgQh19N5a+DtUc5P
	KmFsAnn184fg/0a0hxjSwZ62bBfpGZZOjuOcXgY3l9lUWJbPz45Q1ohR2Z7o/X+qX/qswkxmtDlGq
	Ob1xITV/8YaPpBgcCxESXP20xkXXMY68nftFDKiBphgr6guuAyWYk2U6sKKJroaTwx9t3BWXuI2uF
	Z4Gyzc3IoOPYhDqm5nCfK21zHU9Q8uhBTdyl0zlb4V3tr02sFngSmhe/GPO0/ZN+H1JsIPBJvPVeJ
	0bnjeZLuKwIDEHyfkjeXRXFFq2ook2hn8/G0mLMTqaG0yld5NjoK2XntOe90k/LIKTPuGuzhUYiQ0
	oAjeYNRg==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.92)
	(envelope-from <mac@mcrowe.com>)
	id 1lTmzY-0003P5-GO; Tue, 06 Apr 2021 15:47:44 +0100
Date: Tue, 6 Apr 2021 15:47:44 +0100
From: "Mike Crowe" <yocto@mac.mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Three copies of output from failing task
Message-ID: <20210406144744.GA12232@mcrowe.com>
References: <20210330143049.GA23723@mcrowe.com>
 <91a330cddbd20f81fa40d5f3ce6a3f582f91d200.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <91a330cddbd20f81fa40d5f3ce6a3f582f91d200.camel@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfMPKJEWQvKFfc/CFjZKsOsqTczF7xh/g9zWgUL0oi3QyQnZAmcvSWbYtCLfBVkuYhatlCnVoFeX62wgyy7z9foGu+PwsZCz30Q7D447hG+liaWupfCv/
 ncPOAOepPLHRITwXVtYWt7cH5PTHVHgt8eVL6jU4anb+nR6Bw6dlbSWA0o0+Jeg+WxShMi5GXqw+qA==
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tuesday 06 April 2021 at 15:26:02 +0100, Richard Purdie wrote:
> On Tue, 2021-03-30 at 15:30 +0100, Mike Crowe via lists.openembedded.org wrote:
> > After upgrading from oe-core Warrior (Bitbake 1.42) to Dunfell (Bitbake
> > 1.46), I'm seeing _three_ copies of the log output for every build failure.
> > I see similar when using the current state of oe-core master (along with
> > the new backtraces.)
> > 
> > To reproduce the problem, I hacked openssl_1.1.1k.bb:do_configure to insert:
> > 
> >  echo "an error"
> >  false
> > 
> > and ran bitbake openssl-native. The output was:
> > 
> > --8<--
> > NOTE: Executing Tasks
> > ERROR: openssl-native-1.1.1k-r0 do_configure: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
> > an error
> > WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> > WARNING: Backtrace (BB generated script):
> >         #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> >         #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> > 
> > Backtrace (metadata-relative locations):
> >         #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
> > ERROR: Logfile of failure stored in: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/log.do_configure.32031
> > Log data follows:
> > > DEBUG: Executing python function extend_recipe_sysroot
> > > NOTE: Direct dependencies are ['/overflow/mac/nobackup/git/oe-core/meta/recipes-devtools/quilt/quilt-native_0.66.bb:do_populate_sysroot']
> > > NOTE: Installed into sysroot: []
> > > NOTE: Skipping as already exists in sysroot: ['quilt-native']
> > > DEBUG: Python function extend_recipe_sysroot finished
> > > DEBUG: Executing shell function do_configure
> > > an error
> > > WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> > > WARNING: Backtrace (BB generated script):
> > >       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> > >       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> > > ERROR: Execution of '/overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031' failed with exit code 1:
> > > an error
> > > WARNING: /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031:143 exit 1 from 'false'
> > > WARNING: Backtrace (BB generated script):
> > >       #1: do_configure, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 143
> > >       #2: main, /overflow/mac/nobackup/git/oe-core/build/tmp-glibc/work/x86_64-linux/openssl-native/1.1.1k-r0/temp/run.do_configure.32031, line 221
> > > 
> > > Backtrace (metadata-relative locations):
> > >       #1: do_configure, /overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb, line 78
> > ERROR: Task (virtual:native:/overflow/mac/nobackup/git/oe-core/meta/recipes-connectivity/openssl/openssl_1.1.1k.bb:do_configure) failed with exit code '1'
> > NOTE: Tasks Summary: Attempted 14 tasks of which 13 didn't need to be rerun and 1 failed.
> > -->8--
> > 
> > Even if I set BBINCLUDELOGS="no", I still get these three copies.
> > 
> > The first one (without the leading "|" characters) appears to come from
> > _build.py:_exec_task (around line 702) executing logger.error(str(exc)).
> > This line dates from 2011.
> > 
> > The second and third ones (with the leading "|") come from knotty.py around
> > line 767. They are both in log.do_configure.32031. It looks like the third
> > copy is coming from the same place as the first copy, but has been written
> > to both the console and the log file.
> > 
> > If I comment out the previously-mentioned call to logger.error(str(exc)) in
> > _build.py:_exec_task then I get the single copy of the task output as I
> > would expect.
> > 
> > Does anyone know what the proper fix for this might be?
> 
> Thanks for the report and analysis. I think we should do something about it
> but having stared at the code a bit, I'm still not entirely sure what. I think
> the trouble is the error is being reported at mutliple levels in the code
> and we;re a bit paranoid about doing that as there is nothing worse than
> a failure where the traceback isn't shown.
> 
> I'll have to stare at it a bit more but wanted you to know I've at least
> looked at it and agree we should try and do something...

Thanks for looking at it. I did plan to try to dig further into it after
Ross's response, but haven't had a chance yet. If even you're not sure what
the right thing to do is then I don't have any great hopes that I'll be
able to solve it!

Thanks.

Mike.
