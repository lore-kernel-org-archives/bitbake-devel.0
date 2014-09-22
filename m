Return-Path: <ross.burton@intel.com>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
	[209.85.216.42])
	by mail.openembedded.org (Postfix) with ESMTP id 3654660144
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 19:20:23 +0000 (UTC)
Received: by mail-qa0-f42.google.com with SMTP id dc16so607487qab.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 12:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=i1ypDFyLI/Ab6kmmM0dnJRggTRo0KEQWhXJSItYn8lQ=;
	b=jCI2Q2fDBY9dr+kXD7feAilEpyXYT44Tpk/1noCO1kv4IGboNr+Tj8e4N5z5VzmqNJ
	C9UvYJW7o/BQPPXdfYWNtqsqJb1bLgUgeSXYcSnzNvwCectLWH2sWLc7ZkYbX8cTcSO4
	p0aTmfI93doQXlc5whzMvpq4WLBpfVjUVN6qDTSf6i0SpVgUFgwBzWaQJ5XM31Vr7iTR
	809eDmTbQkWvpDGZy6aMPmow6iRXCzX6mxGhew1JhoUMS06eGLgO5bnpFAhRamX/eINu
	zyoyhTqxUvMS4L6tnC8pqA8oEZbxmIxFqvqqyseH5Pt7yeoWrld4Mx3OpAkjLml2bwID
	X5yA==
X-Gm-Message-State: ALoCoQlQwMwbLGhvFsGPDzBXeyPuZCnmWwr2rSXWaKbyXqs4he0p7eDHjNFY6wwYFbRQZQkC1r7X
X-Received: by 10.224.63.140 with SMTP id b12mr22136631qai.22.1411413624597;
	Mon, 22 Sep 2014 12:20:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.34.180 with HTTP; Mon, 22 Sep 2014 12:20:04 -0700 (PDT)
In-Reply-To: <54205685.2060104@sonatest.com>
References: <54203B56.5030607@sonatest.com>
	<CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
	<CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com>
	<54205685.2060104@sonatest.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 22 Sep 2014 20:20:04 +0100
Message-ID: <CAJTo0Lbfg7nz7vYLOhT2VuxDCCeO0eBVtmer+ODFQTwfgncTrA@mail.gmail.com>
To: Olivier Dugas <dugaso@sonatest.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake do_unpack checksum?
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
X-List-Received-Date: Mon, 22 Sep 2014 19:20:27 -0000
Content-Type: text/plain; charset=UTF-8

On 22 September 2014 18:04, Olivier Dugas <dugaso@sonatest.com> wrote:
> I personnally would be satisfied by the point made by Richard Purdie in bug
> 5571 (comment 2), that is putting the checksum into the .done file. I
> believe this would indeed avoid errors like the one we got here. Was it
> implemented? If somebody did this, do you know the commit id, so I can try
> to cherry pick it.

Comment 2 is designed to solve a different problem and won't catch the
tarball on disk getting corrupted because it will simply be comparing
a cached checksum in the .done file with the stated checksum in the
recipe.

I'm not sure what points in the Builld Performance page mean you
couldn't trust the resulting image.  There are some tweaks that mean
data loss in the event of power failure (ie no journal, high write
delay) but in this situation the corrupted disk can be reformatted as
it only contains built objects and can be entirely regenerated.

Ross

