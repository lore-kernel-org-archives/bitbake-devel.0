Return-Path: <raj.khem@gmail.com>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
	[209.85.213.178])
	by mail.openembedded.org (Postfix) with ESMTP id A93856FEF6;
	Wed,  3 Feb 2016 05:36:33 +0000 (UTC)
Received: by mail-ig0-f178.google.com with SMTP id z14so78192138igp.1;
	Tue, 02 Feb 2016 21:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=QwqPveBmQS0Fwcex/LzUPSAw6KV5jc4GZOoqeeZOdgo=;
	b=t/zpaMKUpVfqxfkTf0hPP07JA7aKYtyLoXI5P9U/tWIoMqjxfNgvJ/DATICeJOdQsc
	jv5APd5EQbqr96eRb5ddCtFKntQr0ITnSquWt1aIFsh0QhYyXiFkOsRwnvU9bSbPMO1g
	6y/FiaVFoMa6hDjd6WzwmxCQxIN5A6/4+6ZawiyHFzS1xaA+wHgwVrZkpKpfeJMtQso0
	Mo/S5jdhmFhV1zp0SktJ0d7yCK7lJWRr5VDgyBo7iOPFOpE7Q8c6fSZC0QMhysw3DXqK
	jZOr3OyMLI6TyE7s+loIDwjvJ3D2L8BSq+5lq6dTdAe6Y027eC6d7MuhsFSEmNxrx69O
	ktUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=QwqPveBmQS0Fwcex/LzUPSAw6KV5jc4GZOoqeeZOdgo=;
	b=aFrXWygahnQHjT3787mTSZBF2M7T6daeYDu5tEBzwX5ULscD+4LXDcuKuDgbzk2NoX
	Bdk8BdkFT7HR77T17jOUIjgyawEU8hscU9COErbprcMrSr9WubfHgrxhkJwnToVsfoWr
	h0Ubw8bTmwFDYqLb5ToBrSsSblH+YuuYKilx7gMLrBkC9li79WH7b8WhP3Kq/VVs5xtL
	FzwcFiIGwdisZ/LnBTf8UpbI5e+/WWNGhDRXgP5KDf7ZTXKoCUYEr1JFvLloRSXoavlC
	RqFiZZHceGRuTNXsbqNEik11p1+OUCeyG4On1pwfwqRSOTwFcvRP2f3jRNCV64WFZuyU
	OTJg==
X-Gm-Message-State: AG10YOSiFFI9A58iS+7+5A1f+i68BxcTMz+J6Ok/Dm1c1gzY0ewhf8CHQ/ZN/Hok9SXzFlzK99r9gtL0mcztgw==
X-Received: by 10.50.134.129 with SMTP id pk1mr22045020igb.11.1454477794038;
	Tue, 02 Feb 2016 21:36:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.46.219 with HTTP; Tue, 2 Feb 2016 21:36:04 -0800 (PST)
In-Reply-To: <1454457337.27087.142.camel@linuxfoundation.org>
References: <1454457337.27087.142.camel@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 2 Feb 2016 21:36:04 -0800
Message-ID: <CAMKF1spSfcfM-AAC4fPNUiRykQaZ0_zUpzQNFfb8nOOeS7t8-g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVarFlag [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 05:36:34 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Feb 2, 2016 at 3:55 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> At some point in the future, getVarFlag should expand by default. To
> get there from the current position, we need a period of time where the
> expand parameter is mandatory.
>

what are advantages of this.

> This patch starts that process. Clear errors will result from any code
> which doesn't provide this. Layers can be fixed with an expression
> like:
>
> sed -e 's:\(\.getVarFlag([^,()]*, [^,()]*\)):\1, False):g' -i `grep -ril getVar *`
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
> index 79bec1b..d61ad53 100644
> --- a/bitbake/lib/bb/data_smart.py
> +++ b/bitbake/lib/bb/data_smart.py
> @@ -663,7 +663,7 @@ class DataSmart(MutableMapping):
>                  self.dict["__exportlist"]["_content"] = set()
>              self.dict["__exportlist"]["_content"].add(var)
>
> -    def getVarFlag(self, var, flag, expand=False, noweakdefault=False, parsing=False):
> +    def getVarFlag(self, var, flag, expand, noweakdefault=False, parsing=False):
>          local_var = self._findVar(var)
>          value = None
>          if flag == "_content" and var in self.overridedata and not parsing:
>
>
> _______________________________________________
> Openembedded-architecture mailing list
> Openembedded-architecture@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture

