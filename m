Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SfAL8-00085p-NJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 15:43:59 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5EDXIVB009645
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 14 Jun 2012 06:33:19 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 14 Jun 2012 06:33:18 -0700
Message-ID: <4FD9E81D.6030808@windriver.com>
Date: Thu, 14 Jun 2012 08:33:17 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
	<1339643381-23026-5-git-send-email-jason.wessel@windriver.com>
	<1339679039.24333.76.camel@ted>
In-Reply-To: <1339679039.24333.76.camel@ted>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] fetch2/git.py: Optimize clone fall back when it is local
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
X-List-Received-Date: Thu, 14 Jun 2012 13:43:59 -0000
X-Groupsio-MsgNum: 2284
Content-Type: multipart/mixed; boundary="------------080400080402010109070000"

--------------080400080402010109070000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 06/14/2012 08:03 AM, Richard Purdie wrote:
> On Wed, 2012-06-13 at 22:09 -0500, Jason Wessel wrote:
>> A file:// url should use "clone -s" to greatly speed
>> up the clone in the case of a kernel when it is local.
>>
>> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
>> ---
>>  lib/bb/fetch2/git.py |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 1ad9213..f5a3983 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -192,7 +192,13 @@ class Git(FetchMethod):
>>  
>>          # If the repo still doesn't exist, fallback to cloning it
>>          if not os.path.exists(ud.clonedir):
>> -            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
>> +            if repourl.startswith("file://"):
>> +                use_s = "-s"
>> +                repo = repourl[7:]
>> +            else:
>> +                use_s = ""
>> +                repo = repourl
>> +            clone_cmd = "%s clone %s --bare --mirror %s %s" % (ud.basecmd, use_s, repo, ud.clonedir)
>>              if ud.proto.lower() != 'file':
>>                  bb.fetch2.check_network_access(d, clone_cmd)
>>              runfetchcmd(clone_cmd, d)
> 
> How about always using the -l option instead?
> 

I just had to put it through some testing first.  Yes I agree it is fine to use -l as well.

Attached is the new version of the patch.

Jason.

--------------080400080402010109070000
Content-Type: text/x-diff;
	name="0001-fetch2-git.py-Optimize-clone-fall-back-when-it-is-lo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-fetch2-git.py-Optimize-clone-fall-back-when-it-is-lo.pa";
	filename*1="tch"

From daa5cc78b294406fd2376697d44c4de1a42d6f34 Mon Sep 17 00:00:00 2001
From: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 12 Jun 2012 13:23:34 -0500
Subject: [PATCH] fetch2/git.py: Optimize clone fall back when it is local

A file:// url should use "clone -l" to greatly speed
up the clone in the case of a kernel when it is local.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/git.py |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index ecc5e0d..d6a08ac 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -188,7 +188,13 @@ class Git(FetchMethod):
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
+            if repourl.startswith("file://"):
+                use_s = "-l"
+                repo = repourl[7:]
+            else:
+                use_s = ""
+                repo = repourl
+            clone_cmd = "%s clone %s --bare --mirror %s %s" % (ud.basecmd, use_s, repo, ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd)
             runfetchcmd(clone_cmd, d)
-- 
1.7.10


--------------080400080402010109070000--
