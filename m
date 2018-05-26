Return-Path: <damien.riegel@savoirfairelinux.com>
X-Greylist: delayed 319 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 26 May 2018 12:28:01 UTC
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 3277374BF2;
	Sat, 26 May 2018 12:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0106A9C2EF1;
	Sat, 26 May 2018 08:22:43 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id v08xWmLYK_JP; Sat, 26 May 2018 08:22:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 568239C3016;
	Sat, 26 May 2018 08:22:42 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id msH4ymxJxyA3; Sat, 26 May 2018 08:22:42 -0400 (EDT)
Received: from workotop.localdomain (modemcable073.90-22-96.mc.videotron.ca
	[96.22.90.73])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 281769C2EF1;
	Sat, 26 May 2018 08:22:42 -0400 (EDT)
Date: Sat, 26 May 2018 08:22:39 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Message-ID: <20180526122238.mlsunfugwsvtha36@workotop.localdomain>
MIME-Version: 1.0
User-Agent: NeoMutt/20180512
Subject: Generating extensible SDK fails because of missing LAYERSERIES_CORENAMES
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
X-List-Received-Date: Sat, 26 May 2018 12:28:03 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,


When generating the extended SDK, my setup fails with the following
error:

  ERROR: Failed to generate filtered task list for extensible SDK:
  ERROR: bitbake failed:
  ERROR: Unable to start bitbake server

I digged into the issue and found out why bitbake doesn't
start.

bitbake thinks layers are incompatible because they define
LAYERSERIES_COMPAT but LAYERSERIES_CORENAMES is not set. So this check
in cookerdata.py fails [1].

The reason this check fails is that the core `meta` layer is not listed
in the generated BBLAYERS, because it's treated in a special way in
populate_sdk_ext.bbclass [2]. So as this layer is not listed in
BBLAYERS, the compatibility check fails and bitbake cannot start.


Shouldn't `meta` simply be added to BBLAYERS as any other layer? If not,
what is the proper way to solve my bug?

[1] https://github.com/openembedded/bitbake/blob/master/lib/bb/cookerdata.py#L397
[2] https://github.com/openembedded/openembedded-core/blob/master/meta/classes/populate_sdk_ext.bbclass#L208

Thank you,
-- 
Damien

