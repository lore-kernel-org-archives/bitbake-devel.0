Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9D1B3606BF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 07:07:08 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t5C779Tg025176
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 12 Jun 2015 00:07:09 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Fri, 12 Jun 2015 00:07:09 -0700
Message-ID: <557A851B.6090506@windriver.com>
Date: Fri, 12 Jun 2015 15:07:07 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: <zboszor@pr.hu>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <5579AAC9.8090508@pr.hu>
In-Reply-To: <5579AAC9.8090508@pr.hu>
X-Forwarded-Message-Id: <5579AAC9.8090508@pr.hu>
Subject: [oe] Bitbake 1.22 GIT fetcher problem with tags
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
X-List-Received-Date: Fri, 12 Jun 2015 07:07:10 -0000
X-Groupsio-MsgNum: 5853
Content-Type: multipart/mixed; boundary="------------060301060507080603040008"

--------------060301060507080603040008
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit


Hi Boszormenyi,

This email should go into bitbake-devel@lists.openembedded.org.	

// Robert

-------- Forwarded Message --------
Subject: [oe] Bitbake 1.22 GIT fetcher problem with tags
Date: Thu, 11 Jun 2015 17:35:37 +0200
From: Boszormenyi Zoltan <zboszor@pr.hu>
Reply-To: openembedded-devel@lists.openembedded.org
To: openembedded-devel@lists.openembedded.org

Hi,

when fetching a git:// source using SRCREV="tag_name", do_fetch often fails.
The attached patch solves it. We still use a Yocto 1.6 based system and it is a 
necessity.
Can you get this or the patch from bitbake's master branch backported into old 
bitbake
branches?

Thanks in advance and best regards,
Zoltán Böszörményi





--------------060301060507080603040008
Content-Type: text/x-patch; name="bitbake-1.22-git-tag-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bitbake-1.22-git-tag-fix.patch"

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
 


--------------060301060507080603040008
Content-Type: text/plain; charset="UTF-8"; name="Attached Message Part"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Attached Message Part"

-- 
_______________________________________________
Openembedded-devel mailing list
Openembedded-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/openembedded-devel


--------------060301060507080603040008--
