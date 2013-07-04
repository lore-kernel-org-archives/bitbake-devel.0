Return-Path: <vishwasinventor@gmail.com>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
	[209.85.216.49])
	by mail.openembedded.org (Postfix) with ESMTP id C5ECB6041E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jul 2013 10:47:49 +0000 (UTC)
Received: by mail-qa0-f49.google.com with SMTP id hu16so707815qab.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Jul 2013 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=XU9MIDm+AMr4YdeeFhXKTBQ3lQGpXw4mny2nwSk9OIE=;
	b=W80bMWGsf8BngAIzUxUS6Bhax6NS22GF9d1o1ceANa4ERle9QSxh/bjecurhvUALhY
	a125WaNZPwlSoJz8WAnKKUx4x/s1rZHS4aIrd0Ik67nvUj9tBaBXkwos6S0AQv/qO/9D
	7LgKadYam87F24LyVsX6YbKNksgcNu7UvlcSRRZ1c1JpXsnwLbgiBmMthQOKp8Z01aFE
	WlF+FJ0lMulAnyQ06NGgHqgxf4xTY+tJNW7ejLNFJVB0H0HACOa8c093ryPpp8yy+L/t
	hLFZqFPkQetpO0vnP0RKuzzft/s4C2QBHLnSGGIsCkvktbROsFpGocLo0kmtYacCJwUz
	NoEg==
X-Received: by 10.49.30.104 with SMTP id r8mr4772486qeh.27.1372934870082; Thu,
	04 Jul 2013 03:47:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.138.144 with HTTP; Thu, 4 Jul 2013 03:47:29 -0700 (PDT)
From: vishwas sharma <vishwasinventor@gmail.com>
Date: Thu, 4 Jul 2013 16:17:29 +0530
Message-ID: <CABrP-503sh+M30M2BhAMETtQjw4DLyT35RJy2=OvaRXt+W=y4w@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Tue, 09 Jul 2013 21:38:12 +0000
Subject: Dependency explorer crashed
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 04 Jul 2013 10:47:50 -0000
Content-Type: multipart/alternative; boundary=047d7bea44843b2ae804e0ad4fa2

--047d7bea44843b2ae804e0ad4fa2
Content-Type: text/plain; charset=ISO-8859-1

When I trying to run dependency explorer the bitbake application crashed
and lock was not released while exiting and now preventing me to run task


$ *bitbake -u depexp psplash*
This UI is only compatible with the -g option

:$ *bitbake -u depexp psplash -g*
[xcb] Unknown request in queue while dequeuing
[xcb] Most likely this is a multi-threaded client and XInitThreads has not
been called
[xcb] Aborting, sorry about that.
python: ../../src/xcb_io.c:179: dequeue_pending_request: Assertion
`!xcb_xlib_unknown_req_in_deq' failed.
Aborted (core dumped)

$ bitbake -g depexp psplash
ERROR: Only one copy of bitbake should be run against a build directory

--047d7bea44843b2ae804e0ad4fa2
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr"><div style>When I trying to run dependency explorer the bitbake application crashed and lock was not released while exiting and now preventing me to run task</div><div style><br></div><div style><br></div><div>

$ <b>bitbake -u depexp psplash</b></div><div>This UI is only compatible with the -g option</div><div><br></div><div>:$ <b>bitbake -u depexp psplash -g</b></div><div>[xcb] Unknown request in queue while dequeuing</div><div>

[xcb] Most likely this is a multi-threaded client and XInitThreads has not been called</div><div>[xcb] Aborting, sorry about that.</div><div>python: ../../src/xcb_io.c:179: dequeue_pending_request: Assertion `!xcb_xlib_unknown_req_in_deq&#39; failed.</div>

<div>Aborted (core dumped)</div><div><br></div><div>$ bitbake -g depexp psplash</div><div>ERROR: Only one copy of bitbake should be run against a build directory</div><div><br></div><div style><br></div></div>

--047d7bea44843b2ae804e0ad4fa2--
