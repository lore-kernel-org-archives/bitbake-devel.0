Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id EFD9C7918F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 08:52:03 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so14988645wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=+zvxXfNCAgTwHbh/Xr/4i5nuMHEbDa+0m0QYoYG8XWU=;
	b=c6xb65rQIRWRjeWvdbB2YuMYiuq2Y3TXjJGJiKdBjJObJebTQ/RGwYhuEWB0x+CWeo
	i3PnFQpaRGlyPhXK9jsQCPRp+h/hecu7g3jnKrKNUiT8wPl3MQglc2/CWiOhFwspKTF2
	kM1BTw5+1F2zDO2TfnukKwdHKYS4aR3xTjGkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+zvxXfNCAgTwHbh/Xr/4i5nuMHEbDa+0m0QYoYG8XWU=;
	b=JI1Q4rd9gFRVge+SuE+UdaotSrHfS0e2WSgjLmOTlVxrZpfQlIcHdbLmt2VQtcg+Ti
	96MHRH9ID1W4YQJ0zauVONWrbx/OrpihZu4zfQE0kzpoNhxLKpZQL3/MMPLvWRcuqs0W
	0H3vSp9cRF2CGlVVBD4dRhBPn3yOlkpd8ERQAkSkvRMS03qnFkvyhLO8+kZG5MZOj8rD
	nYtJCWs+ZrsqBLDRk//LXqlWcU5ohnFxFxDHT8JHnYUl9px5S4dPNdcvz3NL+lAlblMN
	CjAulC3L3TYbC9k38+TA0EFhqT5QBNU+9oY9VJzTz88SVNXJvio7L0VDJrRJ05UAO82V
	oxFg==
X-Gm-Message-State: AOUpUlFjHota07Rn1nxzCT2li36T5V6kVqLnlywd6mIrez2FJpvR1SDR
	pKa8OHHu1/EL6YoL2G8cORcX8g==
X-Google-Smtp-Source: AA+uWPyQa6wX78Inm5Tk/xwtP+QdWGC+f7qtvguwThLwBOz8HMF7koAau8kmAAwCQm+L0AKv2Cy7MQ==
X-Received: by 2002:a1c:a989:: with SMTP id
	s131-v6mr16820355wme.136.1534409524521; 
	Thu, 16 Aug 2018 01:52:04 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	m207-v6sm981754wma.31.2018.08.16.01.52.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 Aug 2018 01:52:03 -0700 (PDT)
Message-ID: <62b7406a8c5edf06dccdc39acf2a5c5741e5d09e.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 16 Aug 2018 09:52:02 +0100
In-Reply-To: <52a52d2a-3f64-812b-2582-2808abaa78b5@prevas.dk>
References: <20180710120334.9609-1-rasmus.villemoes@prevas.dk>
	<52a52d2a-3f64-812b-2582-2808abaa78b5@prevas.dk>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: [PATCH] bb/utils.py: add break_hardlinks helper
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
X-List-Received-Date: Thu, 16 Aug 2018 08:52:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-08-16 at 10:38 +0200, Rasmus Villemoes wrote:
> On 2018-07-10 14:03, Rasmus Villemoes wrote:
> > bb.utils.copyfile is called in a few places with identical src and
> > dst
> > in order to create an st_nlinks==1 version of the file. That that
> > even
> > works relies on an implementation detail of copyfile (namely, that
> > it
> > creates a temporary file and then does a rename). Moreover, it's a
> > waste
> > of time if the file already has st_nlinks==1.
> > 
> > So create a helper that optimizes away the copy in the st_nlinks==1
> > case. Of course, this helper relies on the same implementation
> > detail,
> > but that's now contained within bb.utils itself.
> > 
> > To test that we do at least sometimes hit the no-copy path, I
> > tested
> > locally with
> > 
> >      if sstat[stat.ST_NLINK] == 1:
> > +        bb.note("Woohoo, 2*%d bytes I/O avoided" %
> > sstat[stat.ST_SIZE])
> >          return True
> > 
> > (and the obvious places in oe-core patched), and the do_package log
> > files
> > are indeed filled with woohoo notes.
> 
> Ping.

Merged, sorry about the delay. Was there a corresponding OE-Core patch?
Also, for new API like this we might want to consider adding some tests
to bitbake-selftest...

Cheers,

Richard

