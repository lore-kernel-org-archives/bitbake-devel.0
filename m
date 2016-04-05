Return-Path: <kevin@teforia.com>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
	[209.85.192.49])
	by mail.openembedded.org (Postfix) with ESMTP id 34F2773167
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Apr 2016 21:26:51 +0000 (UTC)
Received: by mail-qg0-f49.google.com with SMTP id y89so21491777qge.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Apr 2016 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=teforia.com; s=google;
	h=mime-version:date:message-id:subject:from:to;
	bh=tW9xVJ43oz6XdYZophQZA5foUL0Fuop/LBZG79lSPoY=;
	b=hY46Vvi/4AtqCjVjrWI91cXnMkLKrXOyyu7S5ifXvWj4Aa6ubNMz7ITEpMAj0egris
	xpvEREeDgIG5tD6ITVBRbTmoRGLxZhbr442e8DaCosJUSc5hD1MYi2+ER+btEgRU3qu1
	7mjNZXB8tOV42ccolqDlYu/49nPRubJoTnVtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
	bh=tW9xVJ43oz6XdYZophQZA5foUL0Fuop/LBZG79lSPoY=;
	b=GxW0XvronKWBjjN5hJ0Qn3H04fPZ/aF2ssLjkQFIMkknWxYFCPkHGGKB0vulIgXgW5
	QdwIPcNrwGiRbkHxnVxK8PY39Gq4mghdKXHFYj781VNK2w1HbF5pgUHGhHhpE18TDeR5
	9mnUtwaMYapRXVzPuxYfefP1/PU5WJj9fbHxRf690ILdfm7HGuR+f9qI9Jp75wH6B/tr
	K3uGWdeRu/TvmjlqiQ6fT39/0gPActPEsURGex1v+leVOzf4XjaNtMWSnpOMBHwkSzkn
	C3GOig5TknF1GDORzJ7ns9l1iooDpSzUTnAMRA6nfzNaNRW5SNXXxQx8UG6ut5IKQWDT
	uXKA==
X-Gm-Message-State: AD7BkJKLTIxZn/IZXUteWZw0boGxiiRCx5Q/ybGOzx4tXWKxO1KspjsPNq9iBIcnxUBvbTwnIXxa9PkFHKR3bw==
MIME-Version: 1.0
X-Received: by 10.140.169.132 with SMTP id p126mr684528qhp.71.1459891611928;
	Tue, 05 Apr 2016 14:26:51 -0700 (PDT)
Received: by 10.233.235.82 with HTTP; Tue, 5 Apr 2016 14:26:51 -0700 (PDT)
Date: Tue, 5 Apr 2016 14:26:51 -0700
Message-ID: <CAOpAm03zZESdXBxqDDTY7c-d0Dms0wgZko1vNaAXBO3sFDNvrw@mail.gmail.com>
From: Kevin Kwan <kevin@teforia.com>
To: bitbake-devel@lists.openembedded.org
Subject: Opkg first boot configure timeout
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
X-List-Received-Date: Tue, 05 Apr 2016 21:26:52 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

In a recipe, I've defined a post install task that executes on first
time bootup.

When executed, I witness the following output from serial console of my device:

[   ***   ] A start job is running for Opkg first boot configure...
(23s / no limit)


How do I define a timeout, in order to prevent the case where my task
ends up in an infinite-loop?

