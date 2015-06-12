Return-Path: <zboszor@pr.hu>
X-Greylist: delayed 1704 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 12 Jun 2015 10:54:28 UTC
Received: from mail7.pr.hu (mail7.pr.hu [87.242.0.7])
	by mail.openembedded.org (Postfix) with ESMTP id 15CFF73FF2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 10:54:28 +0000 (UTC)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
	by frontdoor.pr.hu with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80) (envelope-from <zboszor@pr.hu>) id 1Z3MA0-0002AG-Vn
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Jun 2015 12:26:04 +0200
Received: from host-87-242-63-200.prtelecom.hu ([87.242.63.200]
	helo=s002.sicom.com)
	by mail.pr.hu with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80) (envelope-from <zboszor@pr.hu>) id 1Z3M9x-0000eQ-6Y
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Jun 2015 12:26:02 +0200
Message-ID: <557AB3B6.1020606@pr.hu>
Date: Fri, 12 Jun 2015 12:25:58 +0200
From: Boszormenyi Zoltan <zboszor@pr.hu>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
X-Spam-Score: 0.7 (/)
X-Scan-Signature: 00247148ec76130c8a78f769f9282e76
X-Spam-Tracer: backend.mail.pr.hu 0.7 20150612102602Z
Subject: Bitbake 1.22 GIT fetcher problem with tags
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
X-List-Received-Date: Fri, 12 Jun 2015 10:54:31 -0000
X-Groupsio-MsgNum: 5854
Content-Type: multipart/mixed; boundary="------------080606070605000606060100"

--------------080606070605000606060100
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit

Hi,

when fetching a git:// source using SRCREV="tag_name", do_fetch often fails.
The attached patch solves it. We still use a Yocto 1.6 based system and it is a necessity.
Can you get this or the patch from bitbake's master branch backported into old bitbake
branches?

Thanks in advance and best regards,
Zoltán Böszörményi



--------------080606070605000606060100
Content-Type: text/x-patch;
 name="bitbake-1.22-git-tag-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bitbake-1.22-git-tag-fix.patch"

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5d1a358..3897172 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -339,7 +339,7 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+        search = "refs/heads/%s refs/tags/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name], ud.unresolvedrev[name])
         output = self._lsremote(ud, d, search)
         return output.split()[0]
 


--------------080606070605000606060100--
