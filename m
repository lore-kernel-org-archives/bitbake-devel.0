Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E5B6A71BE5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jan 2018 09:49:43 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w0I9niAf025063
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jan 2018 01:49:45 -0800
Received: from localhost.localdomain (128.224.163.240) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.361.1; Thu, 18 Jan 2018 01:49:44 -0800
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1516179099.git.liezhi.yang@windriver.com>
	<c401ad1ea3d8b6f35e6966258f91ec4c3c7e5e27.1516179099.git.liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <63b0d4b1-fadc-1e61-cc45-67a1de5b8166@windriver.com>
Date: Thu, 18 Jan 2018 17:50:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c401ad1ea3d8b6f35e6966258f91ec4c3c7e5e27.1516179099.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 1/2] cooker.py: the var cre maybe undefined
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
X-List-Received-Date: Thu, 18 Jan 2018 09:49:44 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Sorry, I just found that a better fix should be:

commit 6f2ee522a2a63cbb18d4b52cda9ee88bdfe80784
Author: Robert Yang <liezhi.yang@windriver.com>
Date:   Wed Jan 17 14:26:30 2018 +0800

     cooker.py: skip when BBFILE_PATTERN

     There is nothing to do when BBFILE_PATTERN is empty.

     Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 28717f4..05d26f8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1170,6 +1170,7 @@ class BBCooker:
                  elif regex == "":
                      parselog.debug(1, "BBFILE_PATTERN_%s is empty" % c)
                      errors = False
+                    continue
                  else:
                      try:
                          cre = re.compile(regex)


Updated in the repo:

   git://git.pokylinux.org/poky-contrib rbt/cooker
   http://git.pokylinux.org/cgit.cgi//log/?h=rbt/cooker

Robert Yang (2):
   cooker.py: the var cre maybe undefined
   cooker.py: fix for BBFILE_PATTERN matches bbappend

// Robert

On 01/17/2018 04:52 PM, Robert Yang wrote:
> The cre is not defined when re.compile(regex) raise errors, move the code where
> use it to the try block to fix the problem.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>   lib/bb/cooker.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 28717f4..ebfed0d 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1173,11 +1173,11 @@ class BBCooker:
>                   else:
>                       try:
>                           cre = re.compile(regex)
> +                        self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
>                       except re.error:
>                           parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
>                           errors = True
>                           continue
> -                self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
>           if errors:
>               # We've already printed the actual error(s)
>               raise CollectionError("Errors during parsing layer configuration")
> 

