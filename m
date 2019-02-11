Return-Path: <andre.draszik@gmail.com>
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com
	[209.85.161.41])
	by mail.openembedded.org (Postfix) with ESMTP id CE1477997F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Feb 2019 12:15:30 +0000 (UTC)
Received: by mail-yw1-f41.google.com with SMTP id d190so4067651ywd.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Feb 2019 04:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=0NZaOXt3UIyur7jAhBWb/wVy2anOFV+otlMHodiZ83I=;
	b=lu3vr1z/i3OdWMZKp02uRjRRd97Xe7SLEcIb3PbcoROlBuZvZIxZj5q3C3K7w+P4pM
	XWadgr3uVKPBMrfOaDIBMpCcTDasBmp73Gt6N2ja7Mp5zKwCjNRxWxesPvEIixLeJIq/
	nvqFtIZgfWeJYLC97dQtgTI0xJY3igKI+H4WcWNQ5ULZAtPeWVDMPcfn0bOj1uJgr4Mc
	47wWY66nPFwomzenaDvpt18eK82sRqpydSpcHYtap4B3rmGQNGzNjuaqSoNyIbIeV1uq
	LrgVQIzGaV+DDQsA6G39y2mC48NMBmAbOFxFkPXz3Hf+TlLe+/S9bK4CZENS8o14TUSs
	CQVA==
X-Gm-Message-State: AHQUAuYZbrYBmCCFaOpDy6xvzwAqMX4bg/3uhM3w4vjdjZHjsxH3PmTh
	dvtYIBB2Pklp8f79hbS+Yg8mgxYD
X-Google-Smtp-Source: AHgI3Ib8S5l9gu0bBNbqzWdR2GE3Ruz7PG2YZaESmLAkw0zwb7O8+mFNvEQ7dqe7yRlQPiYsTle+Tg==
X-Received: by 2002:a81:4b02:: with SMTP id y2mr20753719ywa.144.1549887331447; 
	Mon, 11 Feb 2019 04:15:31 -0800 (PST)
Received: from bluvision ([77.107.218.170]) by smtp.gmail.com with ESMTPSA id
	i188sm3831080ywa.88.2019.02.11.04.15.30
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 11 Feb 2019 04:15:30 -0800 (PST)
Message-ID: <0621c7ae797be7855adb5c68811c976fce981387.camel@andred.net>
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Feb 2019 12:15:29 +0000
In-Reply-To: <20190113111824.20921-1-git@andred.net>
References: <20190113111824.20921-1-git@andred.net>
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Subject: Re: [master][PATCH] bitbake: remove True option to getVar calls
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
X-List-Received-Date: Mon, 11 Feb 2019 12:15:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

ping

On Sun, 2019-01-13 at 11:18 +0000, André Draszik wrote:
> From: André Draszik <andre.draszik@jci.com>
> 
> getVar() has been defaulting to expanding by default for
> a long time (2016), thus remove the True option from
> getVar() calls with a regex search and replace.
> 
> Search & replace made using the following command:
>     sed -e 's|\(d\.getVar \?\)( \?\([^,()]*\), \?True)|\1(\2)|g' \
>         -i $(git grep -E 'getVar ?\( ?([^,()]*), ?True\)' \
>              | cut -d':' -f1 \
>              | sort -u)
> 
> Signed-off-by: André Draszik <andre.draszik@jci.com>
> ---
>  classes/base.bbclass  | 2 +-
>  lib/bb/fetch2/git.py  | 2 +-
>  lib/bb/tests/fetch.py | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/classes/base.bbclass b/classes/base.bbclass
> index 71d9ec16..08441fe1 100644
> --- a/classes/base.bbclass
> +++ b/classes/base.bbclass
> @@ -44,7 +44,7 @@ python do_showdata() {
>  	# emit the metadata which isnt valid shell
>  	for e in bb.data.keys(d):
>  		if d.getVarFlag(e, 'python', False):
> -			bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e,
> True)))
> +			bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e)))
>  }
>  
>  addtask listtasks
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 59a2ee8f..8ab4b7e1 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -199,7 +199,7 @@ class Git(FetchMethod):
>              depth_default = 1
>          ud.shallow_depths = collections.defaultdict(lambda:
> depth_default)
>  
> -        revs_default = d.getVar("BB_GIT_SHALLOW_REVS", True)
> +        revs_default = d.getVar("BB_GIT_SHALLOW_REVS")
>          ud.shallow_revs = []
>          ud.branches = {}
>          for pos, name in enumerate(ud.names):
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 6848095c..7b5d9684 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -1280,7 +1280,7 @@ class GitShallowTest(FetcherTest):
>  
>      def fetch(self, uri=None):
>          if uri is None:
> -            uris = self.d.getVar('SRC_URI', True).split()
> +            uris = self.d.getVar('SRC_URI').split()
>              uri = uris[0]
>              d = self.d
>          else:
> @@ -1338,7 +1338,7 @@ class GitShallowTest(FetcherTest):
>  
>          srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
>          self.d.setVar('SRCREV', srcrev)
> -        uri = self.d.getVar('SRC_URI', True).split()[0]
> +        uri = self.d.getVar('SRC_URI').split()[0]
>          uri = '%s;nobranch=1;bare=1' % uri
>  
>          self.fetch_shallow(uri)
> @@ -1510,7 +1510,7 @@ class GitShallowTest(FetcherTest):
>          self.add_empty_file('f')
>          self.assertRevCount(7, cwd=self.srcdir)
>  
> -        uri = self.d.getVar('SRC_URI', True).split()[0]
> +        uri = self.d.getVar('SRC_URI').split()[0]
>          uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
>  
>          self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
> @@ -1536,7 +1536,7 @@ class GitShallowTest(FetcherTest):
>          self.add_empty_file('f')
>          self.assertRevCount(7, cwd=self.srcdir)
>  
> -        uri = self.d.getVar('SRC_URI', True).split()[0]
> +        uri = self.d.getVar('SRC_URI').split()[0]
>          uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
>  
>          self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')


