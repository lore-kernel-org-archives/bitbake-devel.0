Return-Path: <zzs213@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by mail.openembedded.org (Postfix) with ESMTP id C281F60123
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=QHqeg
	pgF6IeMX90acx7FY172x60iSIn6DbP2MTOhzv8=; b=fyQHaXjt6zIHCPfprEH9E
	6/4iDl2EVSBDpSubnzf1hUHzdhqoh+ccM+CXZDEFYh5LIzHks6U40bsVpeN90rdm
	GI/2+hm8DL/GUAiWgCFCehKztP5XNmlrscmUw1duodtK4S4ks+hxrkuEZCzEwNuF
	P0hY4RL6cGZlBc8gTx4dcw=
Received: from [192.168.0.12] (unknown [171.212.168.219])
	by smtp3 (Coremail) with SMTP id DcmowADn7iZizLpXzd2NEQ--.59951S2;
	Mon, 22 Aug 2016 17:56:52 +0800 (CST)
To: bitbake-devel@lists.openembedded.org
References: <0c2145f0-3c85-fe8e-ef71-5008daa03423@126.com>
	<754ba7e8-128f-cd67-7f1c-d3e2a57b006c@126.com>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <d14aa6a9-7e47-55ff-aa24-d9e3892fa677@126.com>
Date: Mon, 22 Aug 2016 17:56:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <754ba7e8-128f-cd67-7f1c-d3e2a57b006c@126.com>
X-CM-TRANSID: DcmowADn7iZizLpXzd2NEQ--.59951S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryUAF4kXFW5Kr17ZrWfAFb_yoW8Cr1rpF
	n7Ga4xAr1jgry8Wr97Jr4Utr1UJw4UtFW7Jr18Jr1v9ws3Jw1kX3yYkr15Kw1UCrs0y34a
	vF4ayrW5Jr1DWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZ3ktUUUUU=
X-Originating-IP: [171.212.168.219]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbi4gTNGVUw4VdxjAAAsc
Subject: Re: question about BBVERSIONS OVERRIDES and PREFERRED_VERSION
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
X-List-Received-Date: Mon, 22 Aug 2016 09:56:53 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


> Use 'bitbake test -e' to examine the overrides of var 'NAME', It is
> still not contain override for '1.1.7':
>
> #
> # $NAME [2 operations]
> #   override[develop]:set
> /home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:10
> #     "version is develop"
> #   override[pp]:set
> /home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:11
> #     "version is pp"
> # pre-expansion value:
> #   "version is pp"
> NAME="version is pp"
>
> Why ? I expect it should contain override for '1.1.7', like this:
>          override[1.1.7]:set
> /home/zzs/temp/bitbake-hello-world/main/../mylayer/test.bb:11
>          ....
> And I found all NAME_xxx, where xxx is [a-z] all OK? I has no idea about
> this.
> Anybody help me?
>

I found using the flowwing patch can solve my problem about override for 
'1.1.7':

============================================================
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 2ab884b..216ba93 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -552,7 +552,7 @@ class DataSmart(MutableMapping):
          # aka pay the cookie monster
          override = var[var.rfind('_')+1:]
          shortvar = var[:var.rfind('_')]
-        while override and override.islower():
+        while override and (override + 'a').islower():
              if shortvar not in self.overridedata:
                  self.overridedata[shortvar] = []
              if [var, override] not in self.overridedata[shortvar]:

============================================================

But, I'm not sure this work for other env.

I don't know why just lower case override permited in  this function.

Version string just include digit and point is very common, but 
islower() return False for these strings.

This behavior is intended or a bug?
Or has another way to solve my problem?


