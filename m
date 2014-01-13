Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E80BE6B5D1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 22:29:26 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0DMTEWp024351; Mon, 13 Jan 2014 22:29:14 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0_Ss8GbgX_Xs; Mon, 13 Jan 2014 22:29:14 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0DMT9cd024336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Jan 2014 22:29:11 GMT
Message-ID: <1389652143.14987.30.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 13 Jan 2014 22:29:03 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: Scott Rifenbark <scott.m.rifenbark@linux.intel.com>
Subject: Bitbake Docs - Headsup
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
X-List-Received-Date: Mon, 13 Jan 2014 22:29:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We need to pull together and sort out the various bits of work that have
been done on the bitbake docs file. I know Bill has done some work
there, there is also quite a bit more that needs doing and Scott
Rifenbark has kindly offered to help out with this.

Firstly there is the question of the wmat branch. Whilst I know Bill has
"merged" that with master several times, the history is rather untidy
and isn't something that in my view we want to preserve or add into the
master branch in its current form as its just too confused. It isn't a
straight forward rebase either unfortunately. 

I've spent a while untangling and straightening some of it out and have
pushed an updated version to wmat. I've also pushed the first few of
these to the wmat2 branch.

wmat2 contains the import of the Yocto Docs formatting/ makefile/
structure which Bill imported and I think makes sense to use since Scott
is familiar with it and it will give a consistent look and feel to the
"bookshelf" of manuals related to OE/Bitbake. It also splits the single
xml file into multiple chapters which is more maintainable.

The trouble is just beyond the wmat2 head, the manual is completely re
indented and re line wrapped which makes moving commits either side of
that point difficult. Master does have some changes we want to keep
which don't make it through that point although I did try to keep the
obvious ones in the rebased wmat branch.

From here, I'm proposing Scott will go through the changes and pick in
things as makes sense from the branch. Process wise, Scott will most
likely send out a summary pull request when he has a batch of changes to
send to the manual. I will aim to read them for technical correctness
and pull as appropriate. Scott is a tech writer, not a developer so I'm
trying to give him some room to do what he needs without a full
developer workflow of full patches to the list etc. He has worked on the
Yocto Project docs in a git repository quite successfully so hopefully
this won't be too much different.

If anyone has any concerns about this, please raise them now as Scott is
itching to fix the manual :)

Cheers,

Richard



