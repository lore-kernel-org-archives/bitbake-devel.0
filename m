Return-Path: <twoerner@gmail.com>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id 9483D60670
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:19:11 +0000 (UTC)
Received: by mail-ie0-f171.google.com with SMTP id tr6so13601272ieb.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=fEnBFRtM73G+IWca/boKEAEBl4rpm/PYvAR0Abe5JQo=;
	b=ZJAJUTsulMy9PLOwsuxRiWZbjnvM0oGWzhCm3dEK5PhwRI1kkpMlatMFW5tMFNMKtP
	KIBTql9jDFe/zTs3thvNSXyyN08+FsiyGo6DRsD/mePGwaPZvPAE+Fcv5OXYpct2Phlv
	jxMYfUw1JN6NCtYiV75hzrccizV0ir/x9MwzxojhyKVTNrpEZ5SzZbC0WYDGTnRLzLzA
	BEW0LTgoHkCGND84F0mNGmPpQB6Np/39pQMMFjHEnvkCn7wnr8aZhMYu8n00O+cJyFeF
	L3haUDnnfnyVp5pomY0DBlZpc3g94R1pMSJK6Sii7IKVIvUnkul4fs1kxv1OF6d1rRph
	cWBA==
X-Received: by 10.50.30.3 with SMTP id o3mr6278267igh.44.1421864352392;
	Wed, 21 Jan 2015 10:19:12 -0800 (PST)
Received: from [192.168.141.85] ([66.49.180.141])
	by mx.google.com with ESMTPSA id qj3sm6424194igc.17.2015.01.21.10.19.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:19:11 -0800 (PST)
Message-ID: <54BFED9D.50701@gmail.com>
Date: Wed, 21 Jan 2015 13:19:09 -0500
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: Chong Lu <Chong.Lu@windriver.com>, 
 bitbake-devel@lists.openembedded.org
References: <cover.1421827025.git.Chong.Lu@windriver.com>
In-Reply-To: <cover.1421827025.git.Chong.Lu@windriver.com>
Subject: Re: [PATCH 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Wed, 21 Jan 2015 18:19:15 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 01/21/15 03:02, Chong Lu wrote:
> $ bitbake-layers show-layer-deps errorlayer,meta-openstack
> Parsing recipes..done.
> Layer                 Dependencies          Git repository                                           Subdirectory
> ===================================================================================================================
> meta-openstack        meta-ruby             git://git.openembedded.org/meta-openembedded             meta-ruby
> meta-openstack        meta-networking       git://git.openembedded.org/meta-openembedded             meta-networking
> meta-openstack        meta-virtualization   git://git.yoctoproject.org/meta-virtualization           
> meta-openstack        openembedded-core     git://git.openembedded.org/openembedded-core             meta
> meta-openstack        meta-oe               git://git.openembedded.org/meta-openembedded             meta-oe
> WARNING: errorlayer is not found in layer index.
> Cloning into '/buildarea2/clu1/source/poky/meta-cloud-services'...
> Add "meta-openstack" to conf/bblayers.conf
> Cloning into '/buildarea2/clu1/source/poky/meta-openembedded'...
> Add "meta-ruby" to conf/bblayers.conf
> Add "meta-networking" to conf/bblayers.conf
> Cloning into '/buildarea2/clu1/source/poky/meta-virtualization'...
> Add "meta-virtualization" to conf/bblayers.conf
> Add "meta-oe" to conf/bblayers.conf

I wouldn't expect a sub-command called "show-layer-deps" to go ahead and
add the shown dependencies to my configuration. Maybe either an explicit
switch or separate "add-layer-deps" command should be added instead?

