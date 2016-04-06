Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id A2C77770A2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:51:38 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id f198so81948539wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=em2+FBve1iHn53kgH9e78WMmOFujPvpzdUtk6hJGlt0=;
	b=QgULRcqYzE5V8xUSy6H/Oi94L5PfG+ujpYf0ZzjitX+YSPzBZRIe4cpXF3r6cZGolc
	NFZ3vkHaqrOifnRquE6KQf2OANP/Njyuz+Db4Tp5PS+heQbaqdQS/aHdUR8HRkqmbf2g
	3YjGNjwRvqIk6ZtRfb8TbdqL6ppFnma2m7L2+ekp6NziE8/PHudyaG97sUGzb6u7lKy9
	e8CrFbt5Q9QN7PE8e/69Xsk+pFbhCGFP8mEryp7LRzy928eTaE0LC1S5TfXKDMfxjBfV
	ss40OL3HsyAsBLyQr0GIUfFsAOYLdDkIFhegDHedijfSQbg0dZ5yBPTpNRgUkpJIdOn1
	ZBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=em2+FBve1iHn53kgH9e78WMmOFujPvpzdUtk6hJGlt0=;
	b=dtfX3A2JGoQoBE0/7tTw3mIPlZe/fFG2+LpHevpFV3wXYjQxM2wNoL/Bvzzzn7QSbc
	T7AdJBxs5vW514/E/cAyc17FUL0SrAjFGlooM4puHk5GH+ix0HcBYUGHWJODeRXTJxDV
	dyD8KnwHa+BfQvTGhluFfYOQwe53AGYtCv245TMvTiSq+QJcfOt2X9Q94lkZGNvAzYcS
	u1O0U/rzLkYB5MuUT3cY5GXLr89skGXo9V0i8lppiWXQhvw05dcz7CFRTLZRWwjs/ynK
	GJew48eYC5EUC2ANWgZiQawEil8gtLNbuaRllQ8vmYiI327i3nvUnndB3NpTz+1Chwck
	t9fg==
X-Gm-Message-State: AD7BkJLvjQ/SsKiptv01FDJTgPKmzrmDiucQrVejSLjgr6sFKG8PE6/A61Aa65lIaF1PwbAC
X-Received: by 10.28.177.134 with SMTP id a128mr25873427wmf.55.1459961498701; 
	Wed, 06 Apr 2016 09:51:38 -0700 (PDT)
Received: from [192.168.2.24] ([83.217.123.106])
	by smtp.googlemail.com with ESMTPSA id
	u3sm25707271wmg.15.2016.04.06.09.51.37
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 06 Apr 2016 09:51:38 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
References: <cover.1459960000.git.michael.g.wood@intel.com>
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <57053E99.1040606@intel.com>
Date: Wed, 6 Apr 2016 17:51:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1459960000.git.michael.g.wood@intel.com>
Subject: Re: [PATCH 00/40] Various fixes from toaster-next
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
X-List-Received-Date: Wed, 06 Apr 2016 16:51:39 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/16 17:33, Michael Wood wrote:
> This patch set contains the fixes for:
>   - Build cacnellation
>   - SSTATE_DIR and DL_DIR
>   - Build launching fixes
>   - Support for building jeth release
>
> They all had a dependency on the build launches fixes which is why this is multiple series in one.
>
> This patchset fixes the following bugs:
>    6787 2.1 Cancelling builds at any point in the build process (edit)
>    7880 2.1M3 Medium+/Normal: Toaster uses the same /tmp dir across releases
>    9058 2.1   Medium/Normal: Bad project MACHINE setting in conf/toaster.conf causes command line builds to fail
>    8958 2.1M3 Medium/Normal: Toaster does not build with the Jethro release
>    6787 2.1   Medium/Enhancement: Cancelling builds at any point in the build process
>    8422 2.1   Medium/Enhancement: we currently don't allow setting of sstate_dir or dl_dir
>
>
>
> are available in the git repository at:
>
>    git://git.yoctoproject.org/poky-contrib michaelw/submit/ed/toaster/project-build-dir-cancel-dldir_sstatedir
>    http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/submit/ed/toaster/project-build-dir-cancel-dldir_sstatedir
>
> Ed Bartosh (24):
>    toaster: don't start bitbake server
>    toaster: get rid of noui option
>    toaster: set BITBAKE_UI environment variable
>    toasterui: add brbe parameter to buildinfohelper
>    uievent: improve BBUIEventQueue code
>    buildinfohelper: improve handling of providermap
>    toasterui: fix brbe reporting
>    toaster: remove startBBServer API
>    toaster: remove release API
>    toaster: add brbe parameter to triggerBuild
>    toaster: modified setLayers API
>    toaster: reimplement triggerBuild
>    toaster: add new parameter to _shellcmd
>    toaster: stop bitbake server after the build
>    toaster: update conf/local.conf
>    toaster: fix jethro build
>    toaster: use bash explicitly
>    toasterui: shutdown on BuildCompleted event
>    toaster: use empty token
>    toaster: add DL_DIR and SSTATE_DIR to oe toasterconf
>    toaster: export BBBASEDIR variable
>    toaster: get bitbake location from BBBASEDIR
>    buildinfohelper: fix KeyError
>    toasterui: update build in internal state
>
> Michael Wood (9):
>    toaster: Move xhr calls for starting and stopping builds
>    toaster: xhr Update the implementation of the build cancellation
>      request
>    toaster: libtoaster Update implementation of startABuild and
>      cancelABuild
>    toaster: bldcontrol models Add a cancelling state the BuildRequest
>    buildinfohelper: Add handler for cancelling a build
>    toaster: mrb_section template Add build cancel button
>    toaster: models Exclude the CANCELLED builds from get_number_of_builds
>    toaster: runbuilds Make runbuilds aware of the build CANCELLED state
>    toaster: runbuilds Clean up runbuilds
>
> Sujith H (7):
>    toaster: bldcontrol Add forceShutDown function to BitbakeController
>    toaster: update BuildEnvironmentController and BitbakeController
>    toaster: models Add cancelled state to build outcome
>    toaster: tables BuildsTable exclude cancelled builds
>    toaster: add DL_DIR and SSTATE_DIR to poky toasterconf
>    toaster: update view to support DL_DIR and SSTATE_DIR
>    toaster: update projectconf.html for DL_DIR and SSTATE_DIR
>
>   bin/toaster                                        |  82 ++---------
>   lib/bb/ui/buildinfohelper.py                       |  49 +++++--
>   lib/bb/ui/toasterui.py                             |  22 +--
>   lib/bb/ui/uievent.py                               |  10 +-
>   lib/toaster/bldcontrol/bbcontroller.py             |  62 +-------
>   lib/toaster/bldcontrol/localhostbecontroller.py    | 152 ++++++++++----------
>   .../bldcontrol/management/commands/runbuilds.py    | 109 +++++++++-----
>   .../migrations/0003_add_cancelling_state.py        |  19 +++
>   lib/toaster/bldcontrol/models.py                   |  27 +++-
>   .../orm/migrations/0006_add_cancelled_state.py     |  19 +++
>   lib/toaster/orm/models.py                          |  12 +-
>   lib/toaster/toastergui/api.py                      | 110 ++++++++++++++
>   lib/toaster/toastergui/static/js/customrecipe.js   |   4 +-
>   lib/toaster/toastergui/static/js/layerBtn.js       |   3 +-
>   lib/toaster/toastergui/static/js/libtoaster.js     |  41 ++++--
>   lib/toaster/toastergui/static/js/mrbsection.js     |  95 ++++++++++++
>   lib/toaster/toastergui/static/js/projectpage.js    |   4 +-
>   lib/toaster/toastergui/static/js/projecttopbar.js  |   6 +-
>   lib/toaster/toastergui/static/js/recipedetails.js  |   4 +-
>   lib/toaster/toastergui/tables.py                   |  48 +------
>   lib/toaster/toastergui/templates/base.html         |   1 +
>   lib/toaster/toastergui/templates/mrb_section.html  | 148 +++++++------------
>   lib/toaster/toastergui/templates/projectconf.html  | 160 ++++++++++++++++++++-
>   lib/toaster/toastergui/urls.py                     |   5 +
>   lib/toaster/toastergui/views.py                    |  40 +++++-
>   25 files changed, 793 insertions(+), 439 deletions(-)
>   create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0003_add_cancelling_state.py
>   create mode 100644 bitbake/lib/toaster/orm/migrations/0006_add_cancelled_state.py
>   create mode 100644 bitbake/lib/toaster/toastergui/api.py
>   create mode 100644 bitbake/lib/toaster/toastergui/static/js/mrbsection.js
>

This cover letter belongs to the series [PATCH 01/38] toaster: don't 
start bitbake server
The create-pull-request script created empty patches for the two patches 
that are destined for meta-poky and oe (toasterconf.json) as they're 
outside the bitbake tree. Hence 38 rather than 40

Michael


