Return-Path: <zzs213@126.com>
Received: from m15-114.126.com (m15-114.126.com [220.181.15.114])
	by mail.openembedded.org (Postfix) with ESMTP id A8AF065CBF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Aug 2016 02:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=zZ2sU
	vulaORvhYfe+DqrJH3DTfDy8j/na+NIMysPN+o=; b=lkbRFo9FpS//bPBVHsaA4
	DgzcQwqU4mpmQfjKSaQxEHNUotZllCA6m+hZV839oHWP7oyX7d8rFyhDozmga4O0
	IL+Uw6bs+q4Yhp4ScOnYhXUkVjg6/cSvEonCDfMsJKnT3pxQbVB2/wsXYh6+LDC2
	sLFNyE4CeQ/OveGWT6qhsg=
Received: from [192.168.0.12] (unknown [171.212.170.252])
	by smtp7 (Coremail) with SMTP id DsmowABHc7TTosNX4+svEw--.5268S2;
	Mon, 29 Aug 2016 10:49:57 +0800 (CST)
References: <1472189699-6646-1-git-send-email-zzs213@126.com>
	<CAMKF1soRMSf9EvC5RMuVuJbyA4dRC=n+B9nSjCXovD_F_zvTwQ@mail.gmail.com>
	<77d61119-5b4f-d897-fa94-4490098219bc@126.com>
	<CABcZANkpWPy6fxnyr4SQL1Zmcv-ckn6yW2Y=4mgMhm59W_Fegg@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <29f98200-a994-e9e1-e46c-31e66813c950@126.com>
Date: Mon, 29 Aug 2016 10:50:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABcZANkpWPy6fxnyr4SQL1Zmcv-ckn6yW2Y=4mgMhm59W_Fegg@mail.gmail.com>
X-CM-TRANSID: DsmowABHc7TTosNX4+svEw--.5268S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr47ZFWfKryDGr1kXr17Awb_yoW8Cw4Up3
	yxGa4Ykr10qr18Cwn7Aw17tFn0ywsrXa1fJrn8Zw1q93ZavrZrZ3yUKF1Yga4DZFy5Ja1I
	vay7Aa4Yyw4Y9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8zuAUUUUU=
X-Originating-IP: [171.212.170.252]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiTxbUGVYY6j4tbQAAsO
Subject: Re: [PATCH] enable override for suffix just include digit and dot
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
X-List-Received-Date: Mon, 29 Aug 2016 02:50:02 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2016年08月28日 03:55, Christopher Larson 写道:
>
> On Sat, Aug 27, 2016 at 12:32 AM, 张忠山 <zzs213@126.com
> <mailto:zzs213@126.com>> wrote:
>
>             Without this patch, if we write these in recipe test.bb
>             <http://test.bb> <http://test.bb>:
>
>                     NAME_1.1.7   = 'version is 1.1.7'
>                     NAME_develop = 'version is develop'
>
>             Use 'bitbake test -e' to observe 'NAME':
>                     #
>                     # $NAME [2 operations]
>                     #   override[develop]:set .../test.bb:10
>             <http://test.bb:10> <http://test.bb:10>
>                     #     "version is develop"
>                     # pre-expansion value:
>                     #   "version is develop"
>                     NAME="version is develop"
>
>             Obviously, override for '1.1.7' missing.
>
>
>         Dot is not allowed in variable names intentionally since its file
>         extension separator. I am not sure if its a good idea to allow it in
>         variable names
>
>
>     Since we can use the path delimeter '/' in override like
>     'virtual/kernel'. Why we can't use dot in override.
>
>     And bitbkae would add 'PV'(which default to '1.0' in OE) to
>     'OVERRIDES'. So using dot in override may not be an issue.
>
>     In bitbake manual, It said we can use BBVERSIONS and override to let
>     sigle recipe support multiple package version
>
>     If we can't use dot in override, Howto use BBVERSIONS? Use embedded
>     python code to set var according version? But it is ugly tahn using
>     override!
>
>
> OVERRIDES .= ":pv-${@'${PV}'.replace('.', '_')}"
> FOO_pv-1_1_7 = "bar"
>

Thanks for your suggestion.
But I found just the folowwing enough:

	OVERRIDES .= ":pv-${PV}"
	FOO_pv-1.1.7 = 'bar'

So I wonder why we must avoid dot in override. Is it mandatory or a 
convention.

And is there some taboos with 'override'. If any it should appear in 
manual I think.

> It's worth noting that you're likely the first person to try using it
> since I added the feature. oe-core moved to a policy where only one
> version of a given recipe is kept in most cases, making it less useful.

Does this means 'BBVERSIONS' would disappeared in th future?




