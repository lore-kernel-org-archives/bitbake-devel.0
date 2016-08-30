Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id A321E60017
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 02:12:19 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id i5so11993359wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Aug 2016 19:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=D9z9pnKUYAucpp0TKpFdJfSkzwnHJrz6nWhZLPzeAYs=;
	b=Qh4JaJnSDwk52UzMX4WxqQCYZfWmxEYhfB98cejScmdeiVfEm2npT/EXkFBRKz3elO
	vtT8i4YPqws9HkU1xBcTzAjvYWX36iEGHMtNzGsvJnahMyNfyUeuGEBnEGaIx44agfoX
	Tctpv/hh32egON/gOcTKUPjn+3Ek+y6nzsPqNf1jyYu2kBQdHxfZYgn5pCrnzMvAbN5h
	FUMd4DTZVg4RZSg6m7KHaOhdDPk4F68GnGwjj7LGG5n593W6TE88S2P35KFSCHQYckr/
	93GW5eVJPvZvQDWdoW91i1g3mmIJ7hI4jJW+m8LGSTXjbNac+aBIAjPXthAkcteEDvt+
	JtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=D9z9pnKUYAucpp0TKpFdJfSkzwnHJrz6nWhZLPzeAYs=;
	b=TKLeNVCTSRFm3s3SLoTCIprsHprykTMXUEZDYpYYfcRVaZfv2tRviuoqk5V4pcoO/4
	LxBbaAKnGb5xAJAPlnCT8ML9YoJc1LF/l/tsFpgI0fTJFrhc9aR/6LOq+j6ag9y1UEp/
	l2Y0QVHlJ+5nxYngLqjpZeQKXvz0+etIlgQjn9+sGGTpHjP+ZDr6dnwrxQRAtASPhxTn
	dMbCu4tpv2JK8O71e+XLLMmH7ZBMIrdPGo8dH0ijtNsVoR8gLgA7fOqENds88rzMLEno
	ak9TMF/DgQwv/c32iWIZceVuy7k49XeOFiXOI6upuwAv02J3hHHpVS7zpruT3CRvqVlH
	t06A==
X-Gm-Message-State: AE9vXwOEt+3xzhRn38FSQg8rf7UtxiXP5pD2oXtH9r4RUQpEZNR/JV4xVZPxMeoLnEDsjg3pTJ7kVIRo42UvGA==
X-Received: by 10.194.164.229 with SMTP id yt5mr781212wjb.39.1472523140033;
	Mon, 29 Aug 2016 19:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.195.10.194 with HTTP; Mon, 29 Aug 2016 19:12:19 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
Date: Mon, 29 Aug 2016 19:12:19 -0700
Message-ID: <CAJ86T=UnA3cUU80pdTfgAvc0Ht-Pc9sJJoUK5rjdvuoUKa+4sw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: How to prevent expansion of bitbake variables inside tasks?
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
X-List-Received-Date: Tue, 30 Aug 2016 02:12:22 -0000
Content-Type: text/plain; charset=UTF-8

Say I want to create a do_install() task which does:

  do_install() {
    echo '${BP} was ${BP}' > ${D}/test
  }

but I don't want first ${BP} bitbake variable to be expanded. ie after
the task has run I want ${D}/test to contain the string "${BP} was
foo-1.0".

What's the recommended way to escape the first ${BP} in do_install()?

