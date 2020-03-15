Return-Path: <matthias.schoepfer@googlemail.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id F28D960EB7
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Mar 2020 14:22:43 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id a5so14836390wmb.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Mar 2020 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=to:cc:from:subject:message-id:date:user-agent:mime-version
	:content-transfer-encoding:content-language;
	bh=AMmOMuq7GKPRnQSu3WMYXCqGdKaWuaR+SH8CZuwjQJk=;
	b=HkJbF3LdQNo5gKWeAJCM16+Zi8WvPqBMpNgRUa/R2t4niRDqkCH0DiAnTeOhoegnNC
	ykttiDK9Vk7+EeSooVZzA9M8Y1pwSblEZx7BLB6GWbj1yhFSeMhGaNhnvvGOCTfmFN0Q
	kg72b8ecbpxjXoGFj6cOKcOImzb50Ib4KpmiAMvXeCzZGBn5TcEMWTlmxgwOSPvd4Jq/
	mu3KkgIZaxraX6lKVGdPmq3H6RYagQtNZF/Oxyg7ibXOUoVeEOp1YcvTtAtvLhkEB9YD
	1VNUph/hV0U/M7HkxapDJwYhM69agFeezA8K0qHkGOA6TQXkznt6ekuPNGXMO3IK7ZwX
	jUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
	:mime-version:content-transfer-encoding:content-language;
	bh=AMmOMuq7GKPRnQSu3WMYXCqGdKaWuaR+SH8CZuwjQJk=;
	b=CyjCGfvrXoHxOrKJcGOLem0D7CBZN7oaH5DXaNH+o4n/66hvaF34MzeOKYvnTUjDC5
	lTRu+Rriw1rI8+ztdKnzw+iSNjcxhtZwJX3iQzCFd6Oziut4WhrBXmWIbVwXHj556IKu
	+y22XxzgIKO72AQk8jDLtBW73yZY9gcxJFuNybMrKPqVCbFEXZXIKR5BwX+tUVb2PU9A
	44NzfTG9TynNnqv3cBpFo6f8K4HI0t/9ZO/ux2oAt18ci9xPeyXMEa0UltE2ybqATkb/
	LWUA8VzRFe6t9LSsvMjNTdEkjIRXyxQ77ORy8g4/Gdrd907KRuKxQ6Ks9RIp315vQTiC
	BjNg==
X-Gm-Message-State: ANhLgQ03W9+0qjDzrs1HgBBadbT2O7RKKM40s2JPMA8V20VNsofTbvQo
	aK1WQ6bgfQg6gwYBr+vpOJU=
X-Google-Smtp-Source: ADFU+vv0KemqBUTdHmh1up9Xf/fhhLEUPcsBSc2tgbyfn4eYmFcmnKyLxkNYIXsDHU2kbgKShEsUQw==
X-Received: by 2002:a1c:a102:: with SMTP id k2mr21391946wme.125.1584282164368; 
	Sun, 15 Mar 2020 07:22:44 -0700 (PDT)
Received: from [192.168.42.165] (tmo-110-85.customers.d1-online.com.
	[80.187.110.85]) by smtp.gmail.com with ESMTPSA id
	c124sm26463074wma.10.2020.03.15.07.22.43
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Sun, 15 Mar 2020 07:22:43 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
From: Matthias Schoepfer <matthias.schoepfer@googlemail.com>
Message-ID: <d529063a-dd27-0bd1-67fd-9f5dffdb7fd8@googlemail.com>
Date: Sun, 15 Mar 2020 15:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.5.0
MIME-Version: 1.0
Subject: git fetcher: does not execute git fetch --tags or similar when HEAD has not changed
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
X-List-Received-Date: Sun, 15 Mar 2020 14:22:44 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hi!

As pointed by Denys Dmytriyenko, I repost here from the yocto project 
mailing list.

We have noticed the following issue: We keep the versions of out 
software by means of tags on the git repositories, i.e. during the 
build, somethings like git describe --tags gets called. In yocto, our 
recipe of SomeLibrary might look then similar to this:

SRC_URI = "git://our.private.gitserver.org/git/SomeLibrary.git;tags=v${PV}"

When we build the image, and *then* apply a tag to HEAD, that was 
already built before, it seems like the tags are not fetched (my guess 
is git fetcher sees that origins HEAD and local HEAD have the same hash 
and is fine with it. I believe this is also true for SRCREV instead of 
tags=).

The error is, that while the correct version is built, it will report 
itself with a wrong version.

Is this a bug? Would you welcome some patch that does git fetch --tags 
in any case?!

Regards,

   Matthias


