Return-Path: <damien.riegel@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id C34AE6FFD8;
	Mon, 28 May 2018 15:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EB0F89C191C;
	Mon, 28 May 2018 11:02:02 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 91K5Qf_xRv4o; Mon, 28 May 2018 11:02:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 352AD9C1C7E;
	Mon, 28 May 2018 11:02:02 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id b-jPhDPKeizj; Mon, 28 May 2018 11:02:02 -0400 (EDT)
Received: from workotop.localdomain (unknown [192.168.50.174])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0B8E39C191C;
	Mon, 28 May 2018 11:02:02 -0400 (EDT)
Date: Mon, 28 May 2018 11:01:58 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Message-ID: <20180528150158.ckk4bfq324i346tu@workotop.localdomain>
References: <20180526122238.mlsunfugwsvtha36@workotop.localdomain>
MIME-Version: 1.0
In-Reply-To: <20180526122238.mlsunfugwsvtha36@workotop.localdomain>
User-Agent: NeoMutt/20180512
Subject: Re: Generating extensible SDK fails because of missing LAYERSERIES_CORENAMES
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
X-List-Received-Date: Mon, 28 May 2018 15:02:03 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Sat, May 26, 2018 at 08:22:39AM -0400, Damien Riegel wrote:
> Hi,
> 
> 
> When generating the extended SDK, my setup fails with the following
> error:
> 
>   ERROR: Failed to generate filtered task list for extensible SDK:
>   ERROR: bitbake failed:
>   ERROR: Unable to start bitbake server
> 
> I digged into the issue and found out why bitbake doesn't
> start.
> 
> bitbake thinks layers are incompatible because they define
> LAYERSERIES_COMPAT but LAYERSERIES_CORENAMES is not set. So this check
> in cookerdata.py fails [1].
> 
> The reason this check fails is that the core `meta` layer is not listed
> in the generated BBLAYERS, because it's treated in a special way in
> populate_sdk_ext.bbclass [2]. So as this layer is not listed in
> BBLAYERS, the compatibility check fails and bitbake cannot start.
> 
> 
> Shouldn't `meta` simply be added to BBLAYERS as any other layer? If not,
> what is the proper way to solve my bug?

I think it got confused because the `meta` layer is contained in a
folder named `meta` as well.

I managed to go further in my build with the following snippet:

--- a/meta/classes/populate_sdk_ext.bbclass
+++ b/meta/classes/populate_sdk_ext.bbclass
@@ -207,7 +207,7 @@ python copy_buildsystem () {
     sdkbblayers = []
     corebase = os.path.basename(d.getVar('COREBASE'))
     for layer in layers_copied:
-        if corebase == os.path.basename(layer):
+        if corebase == layer:
             conf_bbpath = os.path.join('layers', layer, 'bitbake')
         else:
             sdkbblayers.append(layer)

> 
> [1] https://github.com/openembedded/bitbake/blob/master/lib/bb/cookerdata.py#L397
> [2] https://github.com/openembedded/openembedded-core/blob/master/meta/classes/populate_sdk_ext.bbclass#L208
> 
> Thank you,
> -- 
> Damien
> -- 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

-- 
Damien Riegel 
Free Software Consultant
Tel: +1 514 276 5468 (ext: 355)

