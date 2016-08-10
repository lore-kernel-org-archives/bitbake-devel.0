Return-Path: <zzs213@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
	by mail.openembedded.org (Postfix) with ESMTP id 92DC877100
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=In/Hx
	p9OEP3iPDJ8sRiYbB9L6SZ9+r1WMVcjguGfx+M=; b=iIspXUFoeJWZrSbCOV6rv
	S4dk0ZZXsESoPHJZL5xdEl1ElYqWKN3kH6/ZaMd0Oxrz+fPw5azu1LXXU0NIQqit
	ldmsF4RWq/XaaifOBvD1sABz/PmXRC4f16X1apP3B95a/2UaepNfSdTkQ15w5kdw
	oFSEOJWzSbGtRYJekbKQpI=
Received: from [192.168.0.12] (unknown [171.212.168.150])
	by smtp3 (Coremail) with SMTP id DcmowABXUrhrhqpXLg7mDg--.13639S2;
	Wed, 10 Aug 2016 09:42:04 +0800 (CST)
References: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
	<CAJTo0LZNQNqiTLWHcegQUXfDAMp+4eahe1jmpJgsWWDhjxfPjw@mail.gmail.com>
	<b560cd81-616c-54a4-c69c-30d0fa6b03d8@126.com>
	<CAJTo0LaGv91=ubi32qcQGx_CYp9gfLTTaQWU2Bpakmjfwnc6DQ@mail.gmail.com>
	<CAJTo0LZN5Y99qUGt0mqybk78VWeo1mUL6WD8AfKbknx66KgxQg@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <5d16cca2-16ff-c09e-e417-413cbf185eef@126.com>
Date: Wed, 10 Aug 2016 09:42:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJTo0LZN5Y99qUGt0mqybk78VWeo1mUL6WD8AfKbknx66KgxQg@mail.gmail.com>
X-CM-TRANSID: DcmowABXUrhrhqpXLg7mDg--.13639S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDQtxDUUUU
X-Originating-IP: [171.212.168.150]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiqAzBGVc1pT5PWAAAsS
Subject: Re: howto rerun a task whenever it's content chang
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
X-List-Received-Date: Wed, 10 Aug 2016 01:42:07 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2016年08月10日 00:42, Burton, Ross 写道:
>
> On 9 August 2016 at 17:40, Burton, Ross <ross.burton@intel.com
> <mailto:ross.burton@intel.com>> wrote:
>
>     Ah, you're using bare bitbake.  You'll want to set
>     BB_SIGNATURE_HANDLER in your bitbake.conf if you want magic
>     autodetection, set it to "BasicHash" should do what you want.
>
>
> Actually I've just been told "basichash". :)
>

Thanks



