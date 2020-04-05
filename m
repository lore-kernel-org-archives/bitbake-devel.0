Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.26363.1586120285881274035
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Apr 2020 13:58:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AXlJrFAN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id w15so8791051wrv.10
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2020 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bj76E5CAY2rEkKicjkIy2zFUyjM1HYyTjfifopRQyus=;
        b=AXlJrFANXfIvwq2TK1xlSZyd493Eti5Br2CCgrI0IpLqL1+SNKb4WNLzzf4ZF10FKK
         PgVldWF9C2uFKITV8CRBaTFv5K3VTolb+gT2Ybrn7zQ5nj9JbKExuDQK1EpIlBa7FrU7
         6qvuYph5umB7HXypk1RIoLJED2cZCLPGw492g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bj76E5CAY2rEkKicjkIy2zFUyjM1HYyTjfifopRQyus=;
        b=UygH26y8o5F+I7nHRouH11PIgvcqlWG0sFbxbwJ5lnxdRKw1+zU0U6DfmYM+ujOMJE
         cGNarh/RqK4tbuGi8MySBqR2kvosk2wzbpYoR8AHG2/W0gLcelJuVBszGDWDoAS3rlzX
         FEbRlAMPChQZCunxOBlxx/IrL/YF0tVJoCN8YaVyJHHKWZQ5nfSHWi3plFWbn+KsmACQ
         Cbm5qzjm8kp3PQnJEdgdV7Uo+9sPNE22NkVKqTu4bdIV9Lrv9QgJwH2v+pK770UhDSAL
         r5K7cJXCtZIvA+VLZeV4Li+WIAiEuNJVKP97dGOcXrU4mElt6AlhmwkwwvVvBAunDBgp
         8H8g==
X-Gm-Message-State: AGi0PuYwF1VPbYXfwaJ5byJs/pS7B5Ns0APoMAPUz5ltBynan9e0/Rwh
	h1qpk9R1HllpumugWv45aHEY9Q==
X-Google-Smtp-Source: APiQypIoEp/i7h6OtXK0uHJt7hpvlaVkD7LlZ6sKLYO/lZrcQ6SwVGPe4ESA3vv585yaG3EyZeD5nA==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr19547268wrr.377.1586120284305;
        Sun, 05 Apr 2020 13:58:04 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id h188sm8265921wme.8.2020.04.05.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 13:58:03 -0700 (PDT)
Message-ID: <cb42c4a02d060b5366b6e22bf3ea31b66be3d05f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Layerindex broken by recent change to bitbake tinfoil
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <bluelightning@bluelightning.org>
Cc: Konrad Scherer <Konrad.Scherer@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 05 Apr 2020 21:58:02 +0100
In-Reply-To: <2650126.UBYc4EziqI@linc>
References: <0675cf46-fd67-9b01-4c77-521099191339@windriver.com>
	 <e0b081d78c3dea3f4cb6b0f549cd66afc49664f3.camel@linuxfoundation.org>
	 <2650126.UBYc4EziqI@linc>
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-04-01 at 08:48 +1300, Paul Eggleton wrote:
> On Wednesday, 1 April 2020 02:25:11 NZDT Richard Purdie wrote:
> > On Tue, 2020-03-31 at 08:27 -0400, Konrad Scherer wrote:
> > > The following commit to bitbake breaks recipe parsing in the
> > > layerindex:
> > > 
> > > commit f2341dc46b6abfc08a4d01c7abdd3d4630577999
> > > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > Date:   Mon Mar 23 12:30:04 2020 +0000
> > > 
> > >      tinfoil: Drop parse_recipe_file custom datastore support
> > > 
> > > The layerindex uses the tinfoil.parse_recipe_file call to build its
> > > database:
> > > 
> > > https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/tree/layerindex/
> > > update_layer.py#n105
> > > 
> > > now fails with the following error message:
> > > 
> > > parse_recipe_file() got an unexpected keyword argument 'config_data'
> > > 
> > > When I remove the config_data argument from the layerindex code the
> > > parsing continues, but I don't
> > > know either code base well enough to determine if this is the correct
> > > solution. How best to resolve
> > > this problem?
> > 
> > Adding Paul to this conversation.
> > 
> > From my reading of the code, config_data comes from config_data_copy
> > and is most unmodified. The only place it is modified is in
> > update_distro_conf_file() which does:
> > 
> > d = utils.parse_conf(path, d)
> > 
> > which amounts to calling bb.parse.handler() on it.
> > 
> > Looking at the code, I'm not sure its intentional that those changes
> > are preserved in config_data_copy.
> > 
> > Paul: Should those distro changes persist in config_data_copy?
> > 
> > If not, the fix is easy and we just remove the parameter. If wanted,
> > that is harder.
> 
> Hang on, leaving the distro conf handling aside for a moment, 
> recipeparse.setup_layer() is where config_data_copy comes from and it is being 
> modified in there - we are parsing conf/layer.conf from the layer and all of 
> its dependencies. If we can't pass that into the recipe parsing then we won't 
> have things from layer.conf, which can turn out to be pretty important for 
> some layers.
> 
> Sorry, I missed this when we reviewed the changes, that's my fault :( I'll 
> have to see what I can come up with in terms of a solution.

I've sent a patch which I think resolves the issue, thankfully it
worked out simpler than I was expecting.

Cheers,

Richard

