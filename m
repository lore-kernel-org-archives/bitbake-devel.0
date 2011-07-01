Received: from gandharva.secretlabs.de ([78.46.147.237])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <holger+oe@freyther.de>) id 1Qce4t-0005qz-Vm
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 15:48:16 +0200
Received: from [192.168.0.101] (91-64-95-94-dynip.superkabel.de [91.64.95.94])
	by gandharva.secretlabs.de (Postfix) with ESMTPSA id 7D12B1B10C09;
	Fri,  1 Jul 2011 13:45:20 +0000 (UTC)
Message-ID: <4E0DCD9A.4030508@freyther.de>
Date: Fri, 01 Jul 2011 15:37:30 +0200
From: Holger Freyther <holger+oe@freyther.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: openembedded-devel@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org
References: <4E03211B.40205@freyther.de>
	<1308828119.21613.138.camel@phil-desktop>
In-Reply-To: <1308828119.21613.138.camel@phil-desktop>
X-Mailman-Approved-At: Sat, 02 Jul 2011 01:11:43 +0200
Subject: Re: [oe] RFC One recipe with two git repository as sources
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
X-List-Received-Date: Fri, 01 Jul 2011 13:48:16 -0000
X-Groupsio-MsgNum: 125
Content-Type: multipart/mixed; boundary="------------010704050509060801000306"

--------------010704050509060801000306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 06/23/2011 01:21 PM, Phil Blundell wrote:
> On Thu, 2011-06-23 at 13:18 +0200, Holger Freyther wrote:
>> -        destdir = os.path.join(destdir, "git/")
>> +        destsuffix = ud.parm.get("destsuffix", "git/")
>> +        print destsuffix
>> +        destdir = os.path.join(destdir, destsuffix)
> 
> I think that "print" might be extraneous, but other than this your patch
> looks awesome.  I think this would resolve the problem that I was having
> in
> http://lists.linuxtogo.org/pipermail/openembedded-core/2011-June/004375.html and to which I never found a solution which didn't involve patching bitbake.
> 

Hi all,

updated patch without the debug print statement in it. what do you think?
could this be applied to the bitbake repository?

holger

--------------010704050509060801000306
Content-Type: text/x-patch;
 name="0001-fetch2-git-Allow-to-specify-the-name-of-the-checkout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-fetch2-git-Allow-to-specify-the-name-of-the-checkout.pa";
 filename*1="tch"

From 5f58446bd2022c149b58a9f8faf738d1b56597a6 Mon Sep 17 00:00:00 2001
From: Holger Hans Peter Freyther <zecke@selfish.org>
Date: Thu, 23 Jun 2011 04:50:13 +0800
Subject: [PATCH] fetch2/git: Allow to specify the name of the checkout directory

Signed-off-by: Holger Hans Peter Freyther <holger@moiji-mobile.com>
---
 lib/bb/fetch2/git.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f3bc793..534c87d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -212,7 +212,8 @@ class Git(FetchMethod):
         else:
             readpathspec = ""
 
-        destdir = os.path.join(destdir, "git/")
+        destsuffix = ud.parm.get("destsuffix", "git/")
+        destdir = os.path.join(destdir, destsuffix)
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-- 
1.7.4.1


--------------010704050509060801000306--
