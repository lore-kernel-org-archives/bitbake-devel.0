Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TbEEV-0005qV-76
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Nov 2012 18:37:08 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so5374051lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2012 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=eFSEe+4zIOcm1rMNeNlAICvfVoAaHRp2A+1t9jETx6k=;
	b=aeB+kP1Fl67xXSJQgmRBBm/XxLFOso29iwxR1vbFNO1fqaT/gsukXw4yy3uceRZ2/Z
	hUDnfoHniUMAWXq5GEa98LkwqcJaTV0YTI3DzSRzvKpQK6mDjT3FzbZvDhNjfmlw/is+
	MurSLEKjdZmCnUDGk1z/TXWz1XXC/2J5ISrFqfxPrMxZ3Z6T8GiMm+lzGqhfWXsct1eI
	dM9Rv8ofSsKMCnnZRiuOQHCEolF3T5Fik1QTmZz8Osscqk7nNUqoFYVNRxTTM3a1b0Mh
	t7lh7ysb3uPaU3iOUf0r+M2d+0rvLfv523cM4SnU4gjGFphdpcl5gO46bNVG7NR1xmVi
	sSOQ==
Received: by 10.152.124.111 with SMTP id mh15mr18393480lab.20.1353518582049;
	Wed, 21 Nov 2012 09:23:02 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Wed, 21 Nov 2012 09:22:41 -0800 (PST)
In-Reply-To: <1353517701.10459.18.camel@ted>
References: <1353489690.10459.0.camel@ted>
	<CABcZAN=G7OB-SE5py+oDGRc4_OyjP3DBvOfKMMFwWLFzpiKeOQ@mail.gmail.com>
	<1353517701.10459.18.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 21 Nov 2012 10:22:41 -0700
X-Google-Sender-Auth: ySPcuTxSH2539GH2diZVS_uMuf4
Message-ID: <CABcZANkBJmcSEtJ5zybzCEJEPa1OTmPpY7Hfq7yOVvJNuNXhag@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] server/process.py: Change timeout error handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 21 Nov 2012 17:37:08 -0000
Content-Type: multipart/alternative; boundary=f46d042f954e47ace704cf049a9f

--f46d042f954e47ace704cf049a9f
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 21, 2012 at 10:08 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> > This code is run in UI context, not server context, no? So the UI
> > should be checking the return of runCommand, seeing the error, and
> > aborting itself in whatever clean fashion is appropriate, rather than
> > the rather less so immediate sys.exit. Given that, I don't really see
> > how switching to bb.fatal here is buying us much. If we truly want
> > that error path to be different from that of other command failures,
> > then I would think that raising an appropriate exception (e.g.
> > something other than SystemExit) would be better.
>
> The issue is that after this particular failure, any further runCommand
> is going to go badly wrong. "Timeout" would imply you could retry and in
> this case as described above, you cannot (which I agree sucks).
>
> So I think exiting in this case isn't such a bad thing although I'm less
> than happy about it. The only thing the UI could do is throw an error
> and exit.


Agreed, but I think that's where the responsibility belongs. From the
perspective of the UI, calling an API that exits you, for any reason, is
pretty disgusting.
-- 
Christopher Larson

--f46d042f954e47ace704cf049a9f
Content-Type: text/html; charset=UTF-8

<div class="gmail_extra"><br><br><div class="gmail_quote">On Wed, Nov 21, 2012 at 10:08 AM, Richard Purdie <span dir="ltr">&lt;<a href="mailto:richard.purdie@linuxfoundation.org" target="_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class="HOEnZb adM"><div class="im">&gt; This code is run in UI context, not server context, no? So the UI<br>
&gt; should be checking the return of runCommand, seeing the error, and<br>
&gt; aborting itself in whatever clean fashion is appropriate, rather than<br>
&gt; the rather less so immediate sys.exit. Given that, I don&#39;t really see<br>
&gt; how switching to bb.fatal here is buying us much. If we truly want<br>
&gt; that error path to be different from that of other command failures,<br>
&gt; then I would think that raising an appropriate exception (e.g.<br>
&gt; something other than SystemExit) would be better.<br>
<br>
</div></div>The issue is that after this particular failure, any further runCommand<br>
is going to go badly wrong. &quot;Timeout&quot; would imply you could retry and in<br>
this case as described above, you cannot (which I agree sucks).<br>
<br>
So I think exiting in this case isn&#39;t such a bad thing although I&#39;m less<br>
than happy about it. The only thing the UI could do is throw an error<br>
and exit.</blockquote></div><br>Agreed, but I think that&#39;s where the responsibility belongs. From the perspective of the UI, calling an API that exits you, for any reason, is pretty disgusting.<br>-- <br>Christopher Larson<br>


</div>

--f46d042f954e47ace704cf049a9f--
