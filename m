Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id AE35F65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 17:05:49 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id q58so2988885wes.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to
	:message-id; bh=2TQKh3bk1GD4WMYemn9cA2/mrMNcg6GptRKx9U0Xz98=;
	b=TbLyksFYPpUgE8sXt0HK19mC00i1rPp5wKXG//WrY8MgH2k7iFVehG818T/U7xJjLz
	5PEK+Rm/6x+LEvpibdxuNIxHpZZkE5r0742nbAGJU47iNJiBaBpuE9m5UyL1BAfKBZlE
	JfBT0EFwMReDykBglRgOBQDld+YOflCqZM5yprkgAZQuo9U3bybiSC6zxy68pgmxQSYm
	NM2raVx1oBoc6FMO8MaPdVG0JRo5tTedYqtvZqHsXZ3eS3naJqIZ3KDOoghnTShYe71W
	5VtVP2LaJtPJn6AxyY5tX7lk4U4968YO4AXDyOslzxOVUI3UFOQ4i5lP9WfkJy6in14O
	ip7Q==
X-Received: by 10.180.206.14 with SMTP id lk14mr29933728wic.71.1421946344820; 
	Thu, 22 Jan 2015 09:05:44 -0800 (PST)
Received: from 046075132200.atmpu0013.highway.a1.net
	(046075132200.atmpu0013.highway.a1.net. [46.75.132.200])
	by mx.google.com with ESMTPSA id j1sm4719839wjw.25.2015.01.22.09.05.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Jan 2015 09:05:44 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <a04905e3262a83cb0c00fcfc9609077200af2da2.1421895046.git.Chong.Lu@windriver.com>
References: <cover.1421895046.git.Chong.Lu@windriver.com>
	<a04905e3262a83cb0c00fcfc9609077200af2da2.1421895046.git.Chong.Lu@windriver.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Thu, 22 Jan 2015 18:05:36 +0100
To: Chong Lu <Chong.Lu@windriver.com>, bitbake-devel@lists.openembedded.org,
	paul.eggleton@linux.intel.com
Message-ID: <77A8CA6E-0A1D-4E38-B4C0-98EAA4711824@gmail.com>
Subject: Re: [PATCH V2 2/2] bitbake-layers: add a ability to	query layer dependencies from layer index
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
X-List-Received-Date: Thu, 22 Jan 2015 17:06:01 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

> (host, port) = parsedurl.netloc.split(":")

Please rsplit, don't add more of these bugs..
http://lists.openembedded.org/pipermail/bitbake-devel/2013-June/003533.html

TIA,

