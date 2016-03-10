Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 7641071633
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 17:01:51 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id n186so39473947wmn.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=5kYosIaouYUbLkDC2dOwUpNzOxGKvzwm9Nqpv03cvTY=;
	b=B6YVbVgUTzG9OFMppvppJbrhVVTyh9hGM//5p8YfBUfhdcdg/mSgmY/N9nAF8eH6zG
	P6kgQBhcYqGm5xIzKnE1EMuijON3fbuEHxzmQCt3D/0XlD1vX0BL+E6UWimQfijZPMlR
	5vqupIB3RRilb2m2OSxGbuDb7GrNkzSg7AqBFJL3CTpCr6jcIhx4g1xzw2awTKXH0Wls
	yKWN7puRj2wWYosBSO74hlvMBY5xO146EpbUjxtfqYgFOlSPIAzPrinXgQJ3JoVyLysi
	e7HUvU6ocH9cCZdC0xg0l+s1SFEqBayFHoA7eP8O9qrTMzCipg0AunbWbTzvYkJuUNMQ
	neRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=5kYosIaouYUbLkDC2dOwUpNzOxGKvzwm9Nqpv03cvTY=;
	b=ehLvNL63oJB/48/l3b9aItn7WHsWLsV8Oa8THmPPI0A9b6AulLXEPSibGChGPtaGGa
	miX36YMY8oe+WzLON797SJXX+PupxUWXxzdM6zSVtMr0us85ykqlVqOw6pFUtOGuhuBP
	cPxtKF3Vn3LLc7100APSlONe6zL/S6xtSt433MwPf8+9f6/z5jcwZCR++LQsOFjOHtxe
	TYO03EHmsg68P+N1s6un2QkLyX7tMNAw5/PxMYzy3LQA3DAtN1v0q9xgen3A/NT3wZQy
	WqFBOi6IB9Tbu39VStPEXSZlK3tOD89W8jrH5kdfeg6mHWr6AlzCeJ2QgGxSlHvO0tsC
	7bkg==
X-Gm-Message-State: AD7BkJLaTbdvIxeNBHhQGtknNtfZTQzctX9F33LdVVLzxjVldtEP85sVIHmiLrMZ/EIJSGrsxW5SHZlxtKvDFw==
MIME-Version: 1.0
X-Received: by 10.194.242.202 with SMTP id ws10mr5053075wjc.3.1457629311465;
	Thu, 10 Mar 2016 09:01:51 -0800 (PST)
Received: by 10.194.201.104 with HTTP; Thu, 10 Mar 2016 09:01:51 -0800 (PST)
In-Reply-To: <1457627432.2804.226.camel@linuxfoundation.org>
References: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
	<1457627432.2804.226.camel@linuxfoundation.org>
Date: Thu, 10 Mar 2016 09:01:51 -0800
Message-ID: <CAJ86T=UGYMQ77dZwMmRytYi75yJ9QOLw5-=RYYO8o03iiQo5fQ@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: include PV in 'Unable to get checksum for SRC_URI entry' warnings
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
X-List-Received-Date: Thu, 10 Mar 2016 17:01:51 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 10, 2016 at 8:30 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2016-03-10 at 08:15 -0800, Andre McCurdy wrote:
>> Referencing PN only is ambiguous if multiple versions of a recipe are
>> present.
>>
>> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
>> ---
>>  lib/bb/fetch2/__init__.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Now that we have recipe level messages getting a prefix during logging,
> do we still need this with master?

Yes, I think so. These warnings get generated during initial parsing,
not as part of executing any task.

> Cheers,
>
> Richard

