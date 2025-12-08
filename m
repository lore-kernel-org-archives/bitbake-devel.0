Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249FAD3B7EA
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 19:46:58 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1664.1765223210064226847
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Dec 2025 11:46:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QAIdWzpY;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6492e78ce07so1848038a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765223208; x=1765828008; darn=lists.openembedded.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V3KU9yXqaoMrTZupkLM8n1Q+r2o9Ch9PGGUw2bb2fos=;
        b=QAIdWzpYKkH13Ezka2aWJKH+Gi47sn18lVCTqoZNzLlNYPQQvFIawMpXUkZ2gtiyZS
         9Q56WQgnDt7zREfjiM01SZtHSpjy48AF5es3A+ZcX0Ug4qY0jXxt3OFA2PoqGpB7+Nib
         6vmr/kHLcUvGDF8lKZpglnYpJNsiCcbu6+P1kI1dumpe+ckVAIz8+BXWRtVIat4N0HOO
         ddRByNwEoAFcUrWTMLlRgpPwW1OogKm2S8KtIMHvjIKMMMJ9mDF3vYeMpvzjYBIbaRqn
         8nYGNFXUUnJwRbn3mHI5q0UDbkqh26/pDw33+3EdUSmmva96i0YB4C4Ukm48PpKMNjua
         36CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765223208; x=1765828008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3KU9yXqaoMrTZupkLM8n1Q+r2o9Ch9PGGUw2bb2fos=;
        b=rg3In8lVnHjxZppXj0dasHScc8S2+GCvHiya9Y3Fofrzn0CKqgvhjfic7cmttGB8xg
         3KWplU/paBetRIciIppKiSmAg4v6dE35omJoRAdfdc4EXVgkS3TX4AUaHQH4Vo1EQkfG
         XqWOEwstMOge0CW3Wy6aBvl/T8oZgWfHaiUMnt5LoQJV4P1K594z1x5rJYibZ4nVu34v
         9L4CmSUu/OQvSLCCNpb+Xw2H9UGc2QCLTACSlvayJzsD9cT8efnJX+9bPBHKeiLqgoJR
         2yh3qEnoF65y8X+xSwkOPlNMSRaGp+I0GA8MV0Tr5+OKqjyUXs0DKXWD+guIlncpFFIu
         OHuw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ev+VNG1Dd0CfujNJ/NqXZABOM6X1JrkUyz4Cv9JCi1/7J8dxMikt9mrEYBvjQ2xsBuuPvEBNS+LBsQdL@lists.openembedded.org
X-Gm-Message-State: AOJu0Yznf5BA83IgYsMQK1wZm4uzkBd55PmXGrcEXd/rHrGUYy8MTpw2
	3WgxOVs8ytmUhv3E5OS4PVQOz2pIj32Fd4zCMcrXLYf5zSz/wzHhDJXk
X-Gm-Gg: ASbGnctXH3TbKzo6g/7uuYkXTat9DxG1dq/e8OR1YIp1XYAYZz/Qaj59pYgd5zUZ/rK
	qKp+ZwYHmHK5ITTGz5dHeCnWDl/UCg5ng8QBW6r5G95TRxo7DB5LUDdmHDlWZgyT9ZrpN2gHzYz
	HCk7sg/oZdZz0UneRNhFwbV8ID5JmFJn1VxSF9pMmnohdTwvR3HR/szsi7Va3yLOQZ1VJbpuyop
	/0bT5Brr/Vz7bCUfUDDLY+Em/xzeEHQEwUfw94pyA9sSKb0TezogbYRuk46JfWymoXssefC66Ux
	9jimVpLUJE5GkrZvW/WdaYZD+mONQ7Ku8mthWKxxKu3NePb9Vh91selGWZ3ySvqnAPI3npbHvHP
	09z4w/ZXsU+utKHNi7AwyiHHNTGNFmYX9Ip2MLqt7NEYmHgWfn9tWk/VmDDWuFj8gPvo5XdfIJk
	P43RbLtvLbXt7p
X-Google-Smtp-Source: AGHT+IFgf6xT7wK9RA5rAT6UY5xFbGeGHFGm21zp6A3DQ1Y0CfB4BIOUJ3jB4m2/fAhzMQOYuEaXaw==
X-Received: by 2002:a17:907:86ab:b0:b73:52c7:faba with SMTP id a640c23a62f3a-b7a242722bbmr902218466b.4.1765223208098;
        Mon, 08 Dec 2025 11:46:48 -0800 (PST)
Received: from osama ([2a02:908:1b4:dac0:c90a:1ef9:90ed:ab9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a898bsm1181624966b.48.2025.12.08.11.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:46:47 -0800 (PST)
Date: Mon, 8 Dec 2025 20:46:45 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: adrian.freihofer@gmail.com
Cc: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH] bitbake: bblayers/query: Add --show-variants
 option to display BBCLASSEXTEND variants
Message-ID: <aTcrJTEdhuMQFPfZ@osama>
References: <20251024164008.4753-1-osama.abdelkader@gmail.com>
 <f74759654e7b562f1177b6fea9b4cabf6072e8ce.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f74759654e7b562f1177b6fea9b4cabf6072e8ce.camel@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18554

On Mon, Dec 08, 2025 at 06:28:12PM +0100, adrian.freihofer@gmail.com wrote:
> On Fri, 2025-10-24 at 19:40 +0300, Osama Abdelkader via
> lists.openembedded.org wrote:
> > The bitbake-layers show-recipes command was hiding BBCLASSEXTEND
> > recipe
> > variants (e.g., devupstream, nativesdk, cross-canadian) by design, to
> > avoid clutter in the output. However, this made it impossible to see
> > recipes like linux-firmware's devupstream variant which uses git
> > snapshots
> > instead of release tarballs.
> > 
> > This patch adds a new --show-variants (-v) option to show-recipes
> > that
> > allows users to view all BBCLASSEXTEND variants when needed, while
> > maintaining the default behavior of hiding them for a cleaner output.
> > 
> > Example usage:
> >   bitbake-layers show-recipes -v linux-firmware
> > 
> > This will now show both:
> >   - Base version: 1:20251011
> >   - Devupstream version: 1:20251011+git
> > 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  bitbake/lib/bblayers/query.py | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/bitbake/lib/bblayers/query.py
> > b/bitbake/lib/bblayers/query.py
> > index eb7cb465b4..11341d5d53 100644
> > --- a/bitbake/lib/bblayers/query.py
> > +++ b/bitbake/lib/bblayers/query.py
> > @@ -52,7 +52,7 @@ layer, with the preferred version first. Note that
> > skipped recipes that
> >  are overlayed will also be listed, with a " (skipped)" suffix.
> >  """
> >  
> > -        items_listed = self.list_recipes('Overlayed recipes', None,
> > True, args.same_version, args.filenames, False, True, None, False,
> > None, args.mc)
> > +        items_listed = self.list_recipes('Overlayed recipes', None,
> > True, args.same_version, args.filenames, False, True, None, False,
> > None, args.mc, False)
> >  
> >          # Check for overlayed .bbclass files
> >          classes = collections.defaultdict(list)
> > @@ -119,9 +119,9 @@ skipped recipes will also be listed, with a "
> > (skipped)" suffix.
> >              title = 'Matching recipes:'
> >          else:
> >              title = 'Available recipes:'
> > -        self.list_recipes(title, args.pnspec, False, False,
> > args.filenames, args.recipes_only, args.multiple, args.layer,
> > args.bare, inheritlist, args.mc)
> > +        self.list_recipes(title, args.pnspec, False, False,
> > args.filenames, args.recipes_only, args.multiple, args.layer,
> > args.bare, inheritlist, args.mc, args.show_variants)
> >  
> > -    def list_recipes(self, title, pnspec, show_overlayed_only,
> > show_same_ver_only, show_filenames, show_recipes_only,
> > show_multi_provider_only, selected_layer, bare, inherits, mc):
> > +    def list_recipes(self, title, pnspec, show_overlayed_only,
> > show_same_ver_only, show_filenames, show_recipes_only,
> > show_multi_provider_only, selected_layer, bare, inherits, mc,
> > show_variants=False):
> >          if inherits:
> >              bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
> >              for classname in inherits:
> > @@ -203,8 +203,10 @@ skipped recipes will also be listed, with a "
> > (skipped)" suffix.
> >                  # We only display once per recipe, we should prefer
> > non extended versions of the
> >                  # recipe if present (so e.g. in OpenEmbedded,
> > openssl rather than nativesdk-openssl
> >                  # which would otherwise sort first).
> > +                # However, if show_variants is True, we show all
> > BBCLASSEXTEND variants.
> >                  if realfn[1] and realfn[0] in
> > self.tinfoil.cooker.recipecaches[mc].pkg_fn:
> > -                    continue
> > +                    if not show_variants:
> > +                        continue
> >  
> >                  if inherits:
> >                      matchcount = 0
> > @@ -229,7 +231,11 @@ skipped recipes will also be listed, with a "
> > (skipped)" suffix.
> >                      for prov in allproviders[p]:
> >                          provfile =
> > bb.cache.virtualfn2realfn(prov[1])[0]
> >                          provlayer = self.get_file_layer(provfile)
> > -                        provs.append((provfile, provlayer, prov[0]))
> > +                        # When show_variants is True, use the
> > virtual filename to distinguish BBCLASSEXTEND variants
> > +                        if show_variants:
> > +                            provs.append((prov[1], provlayer,
> > prov[0]))
> > +                        else:
> > +                            provs.append((provfile, provlayer,
> > prov[0]))
> >                          if provlayer != preflayer:
> >                              multilayer = True
> >                          if prov[0] != pref[0]:
> > @@ -238,10 +244,12 @@ skipped recipes will also be listed, with a "
> > (skipped)" suffix.
> >                          if not items_listed:
> >                              logger.plain('=== %s ===' % title)
> >                              items_listed = True
> > +                        # When show_variants is True, use the
> > virtual filename for preference check
> > +                        pref_cmp_file = pref[1] if show_variants
> > else preffile
> >                          print_item(preffile, p,
> > self.version_str(pref[0][0], pref[0][1]), preflayer, True)
> >                          for (provfile, provlayer, provver) in provs:
> > -                            if provfile != preffile:
> > -                                print_item(provfile, p,
> > self.version_str(provver[0], provver[1]), provlayer, False)
> > +                            if provfile != pref_cmp_file:
> > +                               
> > print_item(bb.cache.virtualfn2realfn(provfile)[0] if show_variants
> > else provfile, p, self.version_str(provver[0], provver[1]),
> > provlayer, False)
> >                          # Ensure we don't show two entries for
> > BBCLASSEXTENDed recipes
> >                          preffiles.append(preffile)
> >  
> > @@ -530,6 +538,7 @@ NOTE: .bbappend files can impact the
> > dependencies.
> >          parser_show_recipes.add_argument('-i', '--inherits',
> > help='only list recipes that inherit the named class(es) - separate
> > multiple classes using , (without spaces)', metavar='CLASS',
> > default='')
> >          parser_show_recipes.add_argument('-l', '--layer', help='only
> > list recipes from the selected layer', default='')
> >          parser_show_recipes.add_argument('-b', '--bare',
> > help='output just names without the "(skipped)" marker',
> > action='store_true')
> > +        parser_show_recipes.add_argument('-v', '--show-variants',
> > help='show all BBCLASSEXTEND recipe variants (e.g., devupstream,
> > nativesdk)', action='store_true')
> 
> 
> During the patch review session, we concluded that -v usually stands
> for “verbose” or often for “version.” Would it be possible to remove -v
> for this somewhat more specific feature and only keep the long option?
> 

Sure, I'm going to send v2.

Thanks,
Osama

> Thank you.
> Adrian
> 
> >          parser_show_recipes.add_argument('--mc', help='use specified
> > multiconfig', default='')
> >          parser_show_recipes.add_argument('pnspec', nargs='*',
> > help='optional recipe name specification (wildcards allowed, enclose
> > in quotes to avoid shell expansion)')
> >  
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#225300):
> > https://lists.openembedded.org/g/openembedded-core/message/225300
> > Mute This Topic: https://lists.openembedded.org/mt/115931358/4454582
> > Group Owner: openembedded-core+owner@lists.openembedded.org
> > Unsubscribe:
> > https://lists.openembedded.org/g/openembedded-core/unsub [
> > adrian.freihofer@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-

