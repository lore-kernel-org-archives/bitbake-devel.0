Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DFA966010D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 11:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u19BlfPE008386
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Feb 2016 11:47:41 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2OUPLaI4LY77 for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 11:47:41 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u19BlZ6p008381
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Feb 2016 11:47:36 GMT
Message-ID: <1455018455.16142.67.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 09 Feb 2016 11:47:35 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Risks with extending the python methodpool
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
X-List-Received-Date: Tue, 09 Feb 2016 11:47:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I started today looking at a backtrace problem where the
filename/lineno entries were works of fiction.

That turned out to be "simple" in that exec_func_python() uses FILE as
the filename which may or may not be the case and is basically wrong.
We can at least fix that not to confuse as much.

I realised that only a certain percentage of our functions are making
it into the methodpool, "def x():" ones do, as does anonymous python
and the ones executed by exec_func_python don't.

This causes some problems since the code fragment that exec_func_python
builds can never really have correct filename/linenos as the code
stands today. I therefore started down the path of "why don't we just
put all functions into methodpool".

This would have some advantages, not least that all the methods would
start to become available from things like devshell.

I had this mostly working, or so I thought, then tried a clean build.
glibc blew up. It does:

do_patch_append() {
    bb.build.exec_func('do_fix_readlib_c', d)
}

and do_fix_readlib_c was no longer being executed.

This is because we'd injected an entry for do_patch into methodpool
(from the export_functions code) before the append was known about.

I guess we've never really supported appending to a def x(): style
python function, or to an anonymous python fragment (it has no name) so
there isn't a current issue but we can't extend the methodpool approach
any further :(.

With this all in mind I can go back to the drawing board on how to fix
the original backtrace problem. It does highlight the need to fix
things in a few areas and some good cleanups that can be made. I
thought I'd better write it down as I'll never remember this in six
months though and I thought some others may find it interesting.

Cheers,

Richard





