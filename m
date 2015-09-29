Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 814AC7680C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 09:54:13 +0000 (UTC)
Received: by wiclk2 with SMTP id lk2so7500365wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 02:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
	:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=5VejA32LeQTvT53J0gDZMlOx9j/BK00ZOFTPPIx5sBQ=;
	b=NLSr7VgbpX5u97nmDxOnrVq5/GBad015jLYFpQDkUCL7H7oLKRPbmFYRZQthqi7fF6
	EcAOYdciIdvMyWGqDjctRHdKKB2PYsLpjdM7r7uKPh9IMzkuwn+5pGt+TlKUiZcvyDmX
	gfja8/dYxMvZvRc03orJ1uXUDGcT0uLLIx4t+8if5DcoKfpHCrEaZnj0XB6RgQx2tqwV
	HYdDawIRRDBZnIS3c3VNt7RbSNS/A8F0wwXr/bU4fByU3xkNQm0pqMdY+Mk33F1pxLLo
	MLZBHxC8p8/VgLaEvs2NfdvQtf066bJe6YfjgPgtZKWl9RBYM2qy9tvhBii6nPHCczvB
	qg6w==
X-Gm-Message-State: ALoCoQmV17+mlpECO2GF2wLsVVqecmU8DB/vkXy1vzAnKpCrbWix8tJauLsMfrlQGYNzkReEhL0l
X-Received: by 10.194.248.234 with SMTP id yp10mr31363949wjc.24.1443520453933; 
	Tue, 29 Sep 2015 02:54:13 -0700 (PDT)
Received: from [192.168.0.22] ([90.212.179.178])
	by smtp.googlemail.com with ESMTPSA id
	fr10sm22926691wib.14.2015.09.29.02.54.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 29 Sep 2015 02:54:13 -0700 (PDT)
Message-ID: <560A5FC4.7050304@intel.com>
Date: Tue, 29 Sep 2015 10:54:12 +0100
From: Michael Wood <michael.g.wood@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <f8bd18184a84e6de1976ecb4d0d929c55bc19a66.1443497922.git.avery.brian@gmail.com>
	<1443520210-4276-1-git-send-email-michael.g.wood@intel.com>
In-Reply-To: <1443520210-4276-1-git-send-email-michael.g.wood@intel.com>
Subject: Re: [PATCH v2 22/22] toaster: orm remove the complicated querying on the ORM
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
X-List-Received-Date: Tue, 29 Sep 2015 09:54:16 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


On 29/09/15 10:50, Michael Wood wrote:
> We no longer need to compute each layer_version and all the recipes
> which belong to this.
>
> [YOCTO #8147]
>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> ---
>   lib/toaster/orm/models.py            | 49 ++++++++++++++++++++++--------------
>   lib/toaster/toastergui/tables.py     |  2 +-
>   lib/toaster/toastergui/typeaheads.py |  5 ++--
>   3 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index 9a052bf..5aed158 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -191,6 +191,7 @@ class Project(models.Model):
>   
>       # returns a queryset of compatible layers for a project
>       def compatible_layerversions(self, release = None, layer_name = None):
> +        logger.warning("This function is deprecated")
>           if release == None:
>               release = self.release
>           # layers on the same branch or layers specifically set for this project
> @@ -205,45 +206,55 @@ class Project(models.Model):
>   
>           return queryset
>   
> -    def projectlayer_equivalent_set(self):
> -        return self.compatible_layerversions().filter(layer__name__in = [x.layercommit.layer.name for x in self.projectlayer_set.all()]).select_related("up_branch")
> +    def get_all_compatible_layer_versions(self):
> +        """ Returns Queryset of all Layer_Versions which are compatible with
> +        this project"""
> +        queryset = Layer_Version.objects.filter(
> +            (Q(up_branch__name=self.release.branch_name) & Q(build=None))
> +            | Q(project=self))
> +
> +        return queryset
> +
> +    def get_project_layer_versions(self, pk=False):
> +        """ Returns the Layer_Versions currently added to this project """
> +        layer_versions = self.projectlayer_set.all().values('layercommit')
> +
> +        if pk is False:
> +            return layer_versions
> +        else:
> +            return layer_versions.values_list('pk', flat=True)
> +
>   
>       def get_available_machines(self):
>           """ Returns QuerySet of all Machines which are provided by the
>           Layers currently added to the Project """
> -        queryset = Machine.objects.filter(layer_version__in=self.projectlayer_equivalent_set)
> +        queryset = Machine.objects.filter(
> +            layer_version__in=self.get_project_layer_versions(self))
> +
>           return queryset
>   
>       def get_all_compatible_machines(self):
>           """ Returns QuerySet of all the compatible machines available to the
>           project including ones from Layers not currently added """
> -        compatible_layers = self.compatible_layerversions()
> +        queryset = Machine.objects.filter(
> +            layer_version__in=self.get_all_compatible_layer_versions())
>   
> -        queryset = Machine.objects.filter(layer_version__in=compatible_layers)
>           return queryset
>   
>       def get_available_recipes(self):
> -        """ Returns QuerySet of all Recipes which are provided by the Layers
> -        currently added to the Project """
> -        project_layers = self.projectlayer_equivalent_set()
> -        queryset = Recipe.objects.filter(layer_version__in = project_layers)
> -
> -        # Copied from get_all_compatible_recipes
> -        search_maxids = map(lambda i: i[0], list(queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
> -        queryset = queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
> -        # End copy
> +        """ Returns QuerySet of all the recipes that are provided by layers
> +        added to this project """
> +        queryset = Recipe.objects.filter(
> +            layer_version__in=self.get_project_layer_versions())
>   
>           return queryset
>   
>       def get_all_compatible_recipes(self):
>           """ Returns QuerySet of all the compatible Recipes available to the
>           project including ones from Layers not currently added """
> -        compatible_layerversions = self.compatible_layerversions()
> -        queryset = Recipe.objects.filter(layer_version__in = compatible_layerversions)
> -
> -        search_maxids = map(lambda i: i[0], list(queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
> +        queryset = Recipe.objects.filter(
> +            layer_version__in=self.get_all_compatible_layer_versions())
>   
> -        queryset = queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
>           return queryset
>   
>   
> diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
> index 3354072..5cc04a2 100644
> --- a/lib/toaster/toastergui/tables.py
> +++ b/lib/toaster/toastergui/tables.py
> @@ -221,7 +221,7 @@ class MachinesTable(ToasterTable, ProjectFiltersMixin):
>   
>       def setup_filters(self, *args, **kwargs):
>           project = Project.objects.get(pk=kwargs['pid'])
> -        self.project_layers = project.projectlayer_equivalent_set()
> +        self.project_layers = project.get_project_layer_versions()
>   
>           self.add_filter(title="Filter by project machines",
>                           name="in_current_project",
> diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
> index d5bec58..9db3182 100644
> --- a/lib/toaster/toastergui/typeaheads.py
> +++ b/lib/toaster/toastergui/typeaheads.py
> @@ -27,7 +27,7 @@ class LayersTypeAhead(ToasterTypeAhead):
>         super(LayersTypeAhead, self).__init__()
>   
>       def apply_search(self, search_term, prj, request):
> -        layers = prj.compatible_layerversions()
> +        layers = prj.get_all_compatible_layer_versions()
>           layers = layers.order_by('layer__name')
>   
>           # Unlike the other typeaheads we also don't want to show suggestions
> @@ -35,7 +35,8 @@ class LayersTypeAhead(ToasterTypeAhead):
>           # layerdeps to a new layer.
>           if ("include_added" in request.GET and
>                   request.GET['include_added'] != "true"):
> -            layers = layers.exclude(pk__in=prj.projectlayer_equivalent_set)
> +            layers = layers.exclude(
> +                pk__in=prj.get_project_layer_versions(pk=True))
>   
>           primary_results = layers.filter(layer__name__istartswith=search_term)
>           secondary_results = layers.filter(layer__name__icontains=search_term).exclude(pk__in=primary_results)
We had a bit of a race condition on creating the pull request, this last 
patch was updated in the original branch but the submission branch was 
branched just before, hence v2 here.

Thanks,

Michael

