Received: from linuxplesk15.openhost.net.nz (linuxplesk15.openhost.net.nz [112.109.81.172])
 by mx.groups.io with SMTP id smtpd.web10.1182.1585689604783457524
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2020 14:20:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 112.109.81.172, mailfrom: bluelightning@bluelightning.org)
Received: from linc.localnet (unknown [165.84.15.3])
	by linuxplesk15.openhost.net.nz (Postfix) with ESMTPSA id F3BD2A1205;
	Wed,  1 Apr 2020 10:20:01 +1300 (NZDT)
Authentication-Results: linuxplesk15.openhost.net.nz;
        spf=pass (sender IP is 165.84.15.3) smtp.mailfrom=bluelightning@bluelightning.org smtp.helo=linc.localnet
Received-SPF: pass (linuxplesk15.openhost.net.nz: connection is authenticated)
From: "Paul Eggleton" <bluelightning@bluelightning.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Konrad Scherer <Konrad.Scherer@windriver.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Layerindex broken by recent change to bitbake tinfoil
Date: Wed, 01 Apr 2020 08:48:41 +1300
Message-ID: <2650126.UBYc4EziqI@linc>
In-Reply-To: <e0b081d78c3dea3f4cb6b0f549cd66afc49664f3.camel@linuxfoundation.org>
References: <0675cf46-fd67-9b01-4c77-521099191339@windriver.com> <e0b081d78c3dea3f4cb6b0f549cd66afc49664f3.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 1 April 2020 02:25:11 NZDT Richard Purdie wrote:
> On Tue, 2020-03-31 at 08:27 -0400, Konrad Scherer wrote:
> > The following commit to bitbake breaks recipe parsing in the
> > layerindex:
> > 
> > commit f2341dc46b6abfc08a4d01c7abdd3d4630577999
> > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Date:   Mon Mar 23 12:30:04 2020 +0000
> > 
> >      tinfoil: Drop parse_recipe_file custom datastore support
> > 
> > The layerindex uses the tinfoil.parse_recipe_file call to build its
> > database:
> > 
> > https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/tree/layerindex/
> > update_layer.py#n105
> > 
> > now fails with the following error message:
> > 
> > parse_recipe_file() got an unexpected keyword argument 'config_data'
> > 
> > When I remove the config_data argument from the layerindex code the
> > parsing continues, but I don't
> > know either code base well enough to determine if this is the correct
> > solution. How best to resolve
> > this problem?
> 
> Adding Paul to this conversation.
> 
> From my reading of the code, config_data comes from config_data_copy
> and is most unmodified. The only place it is modified is in
> update_distro_conf_file() which does:
> 
> d = utils.parse_conf(path, d)
> 
> which amounts to calling bb.parse.handler() on it.
> 
> Looking at the code, I'm not sure its intentional that those changes
> are preserved in config_data_copy.
> 
> Paul: Should those distro changes persist in config_data_copy?
> 
> If not, the fix is easy and we just remove the parameter. If wanted,
> that is harder.

Hang on, leaving the distro conf handling aside for a moment, 
recipeparse.setup_layer() is where config_data_copy comes from and it is being 
modified in there - we are parsing conf/layer.conf from the layer and all of 
its dependencies. If we can't pass that into the recipe parsing then we won't 
have things from layer.conf, which can turn out to be pretty important for 
some layers.

Sorry, I missed this when we reviewed the changes, that's my fault :( I'll 
have to see what I can come up with in terms of a solution.

Paul


