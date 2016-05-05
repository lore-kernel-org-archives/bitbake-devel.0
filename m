Return-Path: <otavio.salvador@ossystems.com.br>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 37FD372DC4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 15:50:08 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id 77so38901008pfv.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 May 2016 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
	h=from:mime-version:in-reply-to:references:date:message-id:subject:to
	:cc; bh=xSPoY+jrwUoERBpjC3MwdpYJvHra2nEIERtswDP6w3U=;
	b=WIiKJaw/I+DM8kHT8oNresLkHZ4siRj0GXt9hsLbzIB+RNkcbKo6jxvdK8xWcnNhXS
	c5eipZdwfui3Z4qrDzi1dIYmVuM1Tj/8929m1EctIlr+Uwyss5tzBqbK5ZBBcezImdg0
	3GZx1PM2XdcT2FxfE0InN3VrS8zFlFnjA1/80RgWGNJ23jbZkFt33bl/2NhV4lXEkOiv
	gLGwbOWZqD0dELhKlyUAP028bv5YD2KMnIapjXjf8tAaNeEmJihHheAtw8HYDSAytMJi
	CPdMkm7cLzx7KP3i5ERAJnkfUhmeec1MZnk3uv2vZogOJXbiLN/zsWX6GIQa2ZT66OXv
	OEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:mime-version:in-reply-to:references:date
	:message-id:subject:to:cc;
	bh=xSPoY+jrwUoERBpjC3MwdpYJvHra2nEIERtswDP6w3U=;
	b=kVz0kNlYlPm3e8GbJOhAz2oI3PD4QMVF3t08drepVBlbqWcVaY6qu3Og7DgwSvX/3Y
	jL8Wln8/Hb0+TGYkOGLRtIvp1a7WblzKwd1cYbgyYH7Pf+h+OBwP1vb+vXvM+c2eS+ra
	ADtNKxwdIJ6o+KE19Oei6PAUb2eVh7ccOzN+G94RiigFyQG9oDZPnJi0onmuODi/LZIE
	pYcMMvo7/ct6qPXq9ov46wrWF3IGZa23G3uyzQa80a3ZXZuU8pmOZRe4Ar4IVKLHtPu5
	J5SS4ImDJKMKa/Wjd4ZdP0DRbZw6zrh9njExDmBedfVQh6hAOEAwfulKkVxGGhNuGnuI
	3hoA==
X-Gm-Message-State: AOPr4FUBcyQdMP+FHSSq0ujeFu/fDTxHR9GlhM6NqxFKWebZq9ayF5+6Jxd15FcjDgCSZw==
X-Received: by 10.98.55.129 with SMTP id e123mr21582351pfa.4.1462463408874;
	Thu, 05 May 2016 08:50:08 -0700 (PDT)
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com.
	[209.85.220.50]) by smtp.gmail.com with ESMTPSA id
	w125sm14658330pfb.53.2016.05.05.08.50.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 May 2016 08:50:07 -0700 (PDT)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-pa0-f50.google.com with SMTP id r5so38324744pag.1;
	Thu, 05 May 2016 08:50:07 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.66.65.169 with SMTP id y9mr21690892pas.102.1462463407212;
	Thu, 05 May 2016 08:50:07 -0700 (PDT)
Received: by 10.66.231.37 with HTTP; Thu, 5 May 2016 08:50:07 -0700 (PDT)
In-Reply-To: <CABcZANkm4caMHo2kutQFBfzhVNxyD50xSS7K0vnHSpmKJj6qvQ@mail.gmail.com>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
	<cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
	<fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
	<CABcZANkm4caMHo2kutQFBfzhVNxyD50xSS7K0vnHSpmKJj6qvQ@mail.gmail.com>
Date: Thu, 5 May 2016 12:50:07 -0300
X-Gmail-Original-Message-ID: <CAP9ODKr0Woo6pVBf9GTS3OTE-gsKBd6_pBdUe5dbjXTgQd3C1Q@mail.gmail.com>
Message-ID: <CAP9ODKr0Woo6pVBf9GTS3OTE-gsKBd6_pBdUe5dbjXTgQd3C1Q@mail.gmail.com>
To: Christopher Larson <clarson@kergoth.com>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Thu, 05 May 2016 15:50:12 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, May 5, 2016 at 12:18 PM, Christopher Larson <clarson@kergoth.com> wrote:
> On Thu, May 5, 2016 at 8:13 AM, Mark Hatle <mark.hatle@windriver.com> wrote:
>> My fear is just we've already got a lot of "broken" (without defining
>> that)
>> layers in the index, and I think it will be worse once the python3 change
>> happens.  I'd really like to make sure we don't confuse people with
>> various errors.
>
> Perhaps we should consider some sort of flag or dependency/versioning
> statement in layer.conf?

What about a bumping the OE-Core LAYERVERSION and force the check in the layers?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

