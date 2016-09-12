Return-Path: <ulfalizer@gmail.com>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
	[209.85.213.44])
	by mail.openembedded.org (Postfix) with ESMTP id 1818F770CD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 20:45:41 +0000 (UTC)
Received: by mail-vk0-f44.google.com with SMTP id f76so155446066vke.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=0r4cR5TdkckVHuBJzQoeOAHaw8oM0z4/HvpgQR6g7VY=;
	b=mtcw1AXQ8ZVuSiyF7AQ71gvrkWwnmLt2iHuVPp+Nodm4RxTGM7oQ/XQh9ZAXIqHQxb
	ivALw2/McnJO3QcNBr4+ICV5D5oU5+PlZ2zgBsoMqSbKHcYYPKGLKnS/FltEoBD5S8ZN
	VNvpSLhzOyeMf7EosgZrckyn8+v071lci1bWlu4wUFZvp8Zhb5R7+zRtQjEOHeQr9vU3
	U1SEE6hhYb//gmudcckA4rsVKIeFUSqe2+44ovfYD4Sw6o3vi8+kxigN7hu/748tL0eg
	Ed3/IIQ5H4H5Awd3V0+2+6+X47kCYoo+Ayl16vv9+zxohlT71UwUO102ymZs4d3VE45I
	mTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=0r4cR5TdkckVHuBJzQoeOAHaw8oM0z4/HvpgQR6g7VY=;
	b=lljEtKW95s1G+FNXUwkINlMlUsnE+Y66skBMSCBcY9xq4F2ahMI59zVE77zo06g3D4
	QbeDDrKEK+wVPudzC3f1THA7WfvyALyHsx9K4jnHuTzTmkPnt8s9GOrkXoAjYnhon2u1
	eCZuAKwUi3O9Ty/+ukLcB1kICiUSR7ay10HXeTUGE+k3ur/k4wAKsR6WsHZhZ6Mp44d1
	jxNfBBjfpFd98ZfgJQB/48ihLZXZci0sJGM5QF1Bqn3mz0zQaO3AbwmiDpCw8G/+F5Op
	L6ZBxm774Z61KXoejLL4wY++M5SSlkD3RV+E+YrfOkg/MNFtoUmk0CgOfsev4ofwAEED
	IhuQ==
X-Gm-Message-State: AE9vXwORxPaoEtQzZff5Smi63ErtVAx2/zAtA3IlGRlKv8a7IF9CELx9eSccq0r0X1DbrDlzB29EqsPVE1R3Lg==
X-Received: by 10.31.12.72 with SMTP id 69mr15026875vkm.62.1473713141683; Mon,
	12 Sep 2016 13:45:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.48.146 with HTTP; Mon, 12 Sep 2016 13:45:41 -0700 (PDT)
In-Reply-To: <CAFkk2KSXctSDxxHCUq2gx3shDfSQ9osshxO9VudX=Wf7akzJNA@mail.gmail.com>
References: <1473711412-22161-1-git-send-email-ulfalizer@gmail.com>
	<CAFkk2KSXctSDxxHCUq2gx3shDfSQ9osshxO9VudX=Wf7akzJNA@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 12 Sep 2016 22:45:41 +0200
Message-ID: <CAFkk2KTT5Sv+coVLQ+SkwCsJxuXRYSK1CZmjKJJXcW7STgThZw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 20:45:42 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 12, 2016 at 10:20 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Mon, Sep 12, 2016 at 10:16 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> Given two names "foo" and "foobar" and SRCREV_FORMAT = "foo_foobar",
>> "foo" might currently get substituted twice. Work around the issue by
>> sorting the list of names by length and substituting longer names first.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>> index 11c75cc..4ca024e 100644
>> --- a/bitbake/lib/bb/fetch2/__init__.py
>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>> @@ -764,7 +764,10 @@ def get_srcrev(d, method_name='sortable_revision'):
>>      seenautoinc = False
>>      for scm in scms:
>>          ud = urldata[scm]
>> -        for name in ud.names:
>> +        # Sort the list of names and replace the longest names first. Given two
>> +        # names "foo" and "foobar", this prevents "foo" being substituted twice
>> +        # in "foo_foobar" (and "foobar" from not being substituted at all).
>> +        for name in sorted(ud.names, key=len, reverse=True):
>>              autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
>>              seenautoinc = seenautoinc or autoinc
>>              if len(rev) > 10:
>> --
>> 2.5.0
>>
>
> A syntax like the following would have been safer, but it might be too
> late for that now.
>
>   SRCREV_FORMAT = "{foo}_{foobar}"
>
> Cheers,
> Ulf

Seems I misread the code. This only works for the case where the same
repository URI is used multiple times in SRC_URI, with a different
name each time. That is probably a relatively rare case.

The basic idea should still work. Suggestions welcome.

Cheers,
Ulf

