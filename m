Return-Path: <msm-oss@mcclintock.net>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id A717F72F44
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Mar 2017 02:56:52 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id j5so2072339pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Mar 2017 18:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=LKtuBA7pSn745Ef4QLXJ4pEikDjTr5vwFepsSwnz8hI=;
	b=hF5SXfrh8WIfp460Y+dme/s5JyFb6nbF03traVBCu+zWTzWgM0bSMEsyhVlLl67ffa
	jlNFK3jHa8DmDP+ldUXIAmZmlCIhpZTszo3rW1Lqv7KHyRjmlIJOqNhZs8/6bPJ29ACL
	Z0nLm89iBWHKRQlD1sTTDFfWyWYOm6wJQihPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=LKtuBA7pSn745Ef4QLXJ4pEikDjTr5vwFepsSwnz8hI=;
	b=Z7PbL2faQoddoeLdwr8FuSVN4QTTah8U6eI18tS76kAfEv3byNCZIxSc6U+iarpac4
	fxyp4u6W/wNdj2r3ZuZtYvSdvAMXbnlyCC+wKw1RkDvWpcTdZgleOA0yeg+1R3B0vtez
	0QMz8rVLAdG7LYk+w+n5KaK11HOaiogk4u+C9P/lel8HqwukUvoNzRwoQq0zlgaX9o2E
	YoDMVCRJ/fs+JGNihqvFuOc5hjObBPqTasOcFy5T6+jPGMJHfHrklPNJDi+70hJ7VX20
	3Ut1db3ihWnae41gRUlXUlx5CFXoEEcTy5G4c9KUgvkElkz2tN8GHLMlpqzyO14EThRE
	po9w==
X-Gm-Message-State: AMke39mZ+TicA2yZi4536P5GyWgFcGN6SFM3SmFJUsuzgobn7AKb9w6SN6M2fulcWPnm7GOpU8BFbPcR0jVexw==
X-Received: by 10.99.64.4 with SMTP id n4mr4183203pga.71.1488941813638; Tue,
	07 Mar 2017 18:56:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.177.198 with HTTP; Tue, 7 Mar 2017 18:56:32 -0800 (PST)
In-Reply-To: <1488941683-21232-1-git-send-email-msm-oss@mcclintock.net>
References: <1488941683-21232-1-git-send-email-msm-oss@mcclintock.net>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Tue, 7 Mar 2017 20:56:32 -0600
Message-ID: <CAEsOVNey=ALiyQfqoxaSjSAn8ABZ28XPhEzCfcObZRtfNGFVYw@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: add option to run all tasks in specific build target
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
X-List-Received-Date: Wed, 08 Mar 2017 02:56:53 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 7, 2017 at 8:54 PM, Matthew McClintock
<msm-oss@mcclintock.net> wrote:
> For example:
>
> $ bitbake core-image-minimal --runall unpack
> ...
> NOTE: Tasks Summary: Attempted 326 tasks of which 88 didn't need to be rerun and all succeeded.
>
> $ bitbake core-image-minimal --runall patch
> NOTE: Tasks Summary: Attempted 453 tasks of which 332 didn't need to be rerun and all succeeded.
>
> This can replace fetchall as well:
> $ bitbake core-image-minimal --runall fetch
> NOTE: Tasks Summary: Attempted 135 tasks of which 119 didn't need to be rerun and all succeeded.
>
> Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
> ---
>  lib/bb/cookerdata.py |  1 +
>  lib/bb/main.py       |  3 +++
>  lib/bb/runqueue.py   | 15 +++++++++++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 53f4587..722d860 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -148,6 +148,7 @@ class CookerConfiguration(object):
>          self.writeeventlog = False
>          self.server_only = False
>          self.limited_deps = False
> +        self.runall = None
>
>          self.env = {}
>
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index 3ff43cf..bda3e0c 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -287,6 +287,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>                            help="Writes the event log of the build to a bitbake event json file. "
>                                 "Use '' (empty string) to assign the name automatically.")
>
> +        parser.add_option("", "--runall", action="store", dest="runall",
> +                          help="Run all tasks in build target that is specified.")
> +
>          options, targets = parser.parse_args(argv)
>
>          if options.quiet and options.verbose:
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index a3b451a..1edc721 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -768,6 +768,7 @@ class RunQueueData:
>
>              # fn already has mc prefix
>              tid = fn + ":" + task
> +            bb.warn("building tid %s" % tid)

Bleh, debug code made it through.

-M

