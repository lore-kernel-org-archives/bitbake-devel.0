Return-Path: <otavio.salvador@gmail.com>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
	[209.85.214.171])
	by mail.openembedded.org (Postfix) with ESMTP id 44FDF6BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 21:46:58 +0000 (UTC)
Received: by mail-ob0-f171.google.com with SMTP id tb18so3259647obb.30
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date:message-id:subject
	:from:to:cc:content-type;
	bh=dbWc8CcwVNrGTVTqyZfmbBUrWgijfjtHvcTSWyEO6wI=;
	b=uGiFsGerj3a/Hb3+oSyhwJseEn5v/k9LTwrodcBshYajCiYXGNLMli9cCuak1iidQc
	4HzBvsie6ZhVpzACmLV9oKBlmjEAZfGzY7JOM5bAmaraNKRrwMKsZNXt0txKTeyLW0zh
	M0wRas23srpZYMzMvhjslVvHhAr84QjEDqUQDXUeDn2r7rMOieqTbEpgt0IhVmPdCU2r
	ylBo53GttJ/T/iTJMHsLOxP3UU+4QCJZRpRIbrXUVnBlEg46EytiCBG2N3jXC4ukdbm/
	Kj8ys3IyKh/srCqErco689IhqISy9GlToBJAG9O+IUvbuJvf8GEW36MHuaRrVzNUSdEN
	9ELw==
MIME-Version: 1.0
X-Received: by 10.182.18.9 with SMTP id s9mr11909016obd.15.1377985617474; Sat,
	31 Aug 2013 14:46:57 -0700 (PDT)
Sender: otavio.salvador@gmail.com
Received: by 10.182.232.166 with HTTP; Sat, 31 Aug 2013 14:46:57 -0700 (PDT)
In-Reply-To: <CABcZAN=pe52=h7NUyBWCE3s2Eu47fbuBwzpAaCdgaY+nmu_v0w@mail.gmail.com>
References: <1377356035.6762.193.camel@ted>
	<CABcZAN=pe52=h7NUyBWCE3s2Eu47fbuBwzpAaCdgaY+nmu_v0w@mail.gmail.com>
Date: Sat, 31 Aug 2013 18:46:57 -0300
X-Google-Sender-Auth: C0FwAPURNFvjaJf5wXFWKPbD25o
Message-ID: <CAP9ODKp5Ek7aHDF5xVTb-DGupDB9MX55G4nBvMdj84t-3QEo7A@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Chris Larson <clarson@kergoth.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] data_smart: Add _remove operator
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
X-List-Received-Date: Sat, 31 Aug 2013 21:47:00 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 26, 2013 at 11:54 AM, Chris Larson <clarson@kergoth.com> wrote:
>
> On Sat, Aug 24, 2013 at 7:53 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>>
>> @@ -583,6 +588,14 @@ class DataSmart(MutableMapping):
>>                  value = copy.copy(local_var["defaultval"])
>>          if expand and value:
>>              value = self.expand(value, None)
>> +        if value and flag == "_content" and local_var and "_removeactive"
>> in local_var:
>> +            for i in local_var["_removeactive"]:
>> +                if " " + i + " " in value:
>> +                    value = value.replace(" " + i + " ", " ")
>> +                if value.startswith(i + " "):
>> +                    value = value[len(i + " "):]
>> +                if value.endswith(" " + i):
>> +                    value = value[:-len(" " + i)]
>
>
> I'm curious, did you profile this implementation vs a split-filter-rejoin?

I noticed it has already been merged but I couldn't comment on this
before as I was in a work trip.

I'd like to thank you both for doing it :)


-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

