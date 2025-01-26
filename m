Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42CFC02181
	for <webhook@archiver.kernel.org>; Sun, 26 Jan 2025 10:28:02 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.89])
 by mx.groups.io with SMTP id smtpd.web10.28078.1737887197255576308
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jan 2025 02:26:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=YKapbGGa;
 spf=pass (domain: navimatix.de, ip: 40.107.159.89, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKdUXW7y/owo7BUpr/NTfUgE0nLSUlDKoJX5Ggj1KbgWKQp5IAW7tqL3PJtkd1UBdHc8q6Tcc1xRpKOj8G2huU6QP4UsX6cJi6hl+dYpBLjVIgkLDh6JfnChmgYeLtbk/e5VwHVAzcCuCGcPZ9eLr7rragxOP2kyP3+beEpnLEHEEDp5dM4WEqhaA46Kwv1+5m5e+yu1oqjZkHavkVFEtCEIgVu3lQKNeZ2nd4LdWQUp1qbUI090cEvlCEa6rawn4lDcKLVhdq3n6g9AfStBv0L7OPwe2Jrpe/+yV8rzMk5/6zWf6a1mKb48AfSyS4hA9xa7Tyc77GkUpaEvAq5b/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T47xuObxQ3g8pA0nj7WVU1sDWZZSK3/m+47Zn7oXB9U=;
 b=FAxEPFfACXKdLkYwOF+W6QTGchID0uyp+etLd1uHX6JUGRvhmRt390WDXpMWRvw15eGR/tKuUpr5P10spjeTa35IcS3AYBWu37RLP4BASr79IMHA1Zlen4sWDyH0JqFsLYGjJy6P+NBGAiICeQCl/7gHMZy6I1BNTmZP7li6Oze9lILQfh0tW1ZlpTKCLzz2CcRVNEKTNdJM80kE+LVIaJ8viina+a7+1qNVQttaBmRFrBgn8DqRuVapWeSQwamTfN1rZNkoVrsSQHh2FvZtL593dDbkJfkd8FjuIjNdw+UtYP7+MIXA/mh+7z9NFMSayLGAg1kz5XOCQDGrDYkGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T47xuObxQ3g8pA0nj7WVU1sDWZZSK3/m+47Zn7oXB9U=;
 b=YKapbGGaWliRpabtLUnmVaBcVtYJDVKLqg6dnC0y5W9sEetcZa/qO26hRHSAQLhy3zmSKxdX6PBu1cv9/AHTy4wdelR5snGCrFdj8ZpJ/Cw1bZkyU51fUv/zSGbNUC+O+G/eecAnwf9EQnT5bYbVRO3M4y4SQHiLwGstpklc8xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:434::5) by VI1PR01MB6992.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:190::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 10:26:31 +0000
Received: from AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 ([fe80::ac1f:a3d4:7e5a:72a9]) by AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 ([fe80::ac1f:a3d4:7e5a:72a9%6]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 10:26:31 +0000
Date: Sun, 26 Jan 2025 11:26:29 +0100
From: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH 2/2] doc/logging: convert warn.json to YAML
Message-ID: <f76mff47hmlhqwq6mgvhbu4xggf3sqiwvvs72n3v7xp2gsay5c@pjtfqzmzuao3>
References: <2bf2a340cbf86391ae6722739f750f9d44f550b3.1735852948.git.joerg.sommer@navimatix.de>
 <bcd0593418a1217f73f4a6946b13a5b603a58fb5.1735852948.git.joerg.sommer@navimatix.de>
 <D6UW0M0VI79V.QRXZOO9V6BPW@bootlin.com>
In-Reply-To: <D6UW0M0VI79V.QRXZOO9V6BPW@bootlin.com>
X-ClientProxiedBy: BE1P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::9) To AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:434::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR01MB8297:EE_|VI1PR01MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2b6883-59e8-400f-c218-08dd3df3e6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clpNUVlXcFVNWDdGVW5lUzJvWGdYL0pNSThpSnlZTzJvb1FHQjUzeThOYXZJ?=
 =?utf-8?B?K2dlRUpXR3k2WUYzdkhKTGh4Z1RCWjZqNlZEbzRMNHVmVURCWnZDdFdNQ1A1?=
 =?utf-8?B?TXRTUlo5VmcvUWF6ajV0KzluK3NYb1dwZHZzbm5HbmR0YUJjVVZEY0UzaFJM?=
 =?utf-8?B?b04wRnZKRy9JR1hLWUNEZXdTb1BudkRFNUlYWXpuMkJVdGhud2NYUkp5NTcw?=
 =?utf-8?B?YVcyYzNjM3ZUSThDbGpmVm14TVJnemh1TUZESzFaclMydHM0OThDSURiR1c1?=
 =?utf-8?B?dUVyNkpUY2VUUVBOemVUcWZPWHJhaVBYN0dQSS9nUk9jeGpJMlRjNXphMzVI?=
 =?utf-8?B?cmRlSmVoM09HU1lXNGdyM3k4TXJXTlVITEZSUGZhRk1OdThITDRpaFdGZGhM?=
 =?utf-8?B?WHFKRUU5aUhmbXhwVms2UUxGUjRJSkNaMEI0NjhoWDEwMjhFbEk0SXJ2QzVD?=
 =?utf-8?B?M01ZcVFNWEN2d0FUaURmK1FTQks2NFZCMitYQ1ZZeWdaRUt3a0hqRmpIbTN0?=
 =?utf-8?B?YkdkSFZrZnlOSGt1bXRzU0xnOEx0WWhTQ0ZUaS8wWHY5bmRCcXROZkxEQ3hz?=
 =?utf-8?B?TEpiRFFIWXNPSEMyUkhreXJZVm8ySHc3cG1VMkFob0ZMaHY5T2FWaHlNTHNv?=
 =?utf-8?B?L3JJc2F6UlNDUzN1dml2NXd1aVRmQnc5OGlOSVY4ZmRwKzY2YmFzUTdVSVhv?=
 =?utf-8?B?TmZEa2xMbXhTNEpqczQ1NGRJY2NmLy8yRWMvTllTMkcvbXVWYzlpdkVVMGlh?=
 =?utf-8?B?NVV0SjVKTndzWFRVTUhNRk55U29HZy9PVXhSVnM4YmhEeS8vVDF5S2tyRVQ0?=
 =?utf-8?B?cjhCK0s2eDJ2OHR4Um1meE1UdmZQbFdFWkd0NmpFM1VnZ2tFNys5UkdkSStR?=
 =?utf-8?B?dXJwRjNwK2VlRXd6elcrV0d4ZjdZd0ZnOFRUOVZFT010aXdNT3VsRkZFcXM1?=
 =?utf-8?B?T0VnMk44dFh5dnM5YmNkNlEzNlZxM1lxVGVyRFBOT3FqMWVnWXdFSXlFSmJZ?=
 =?utf-8?B?MnN5RWhJRk9CMDVIazBVUTZtem9NbUJtbFBQYmQ3RWR0U0l1QTJKUWh2UG5m?=
 =?utf-8?B?K20xR0JPUm1NV04wMXNTYjZySlg4cXh1RW0yNFYrcmdZWnJ4eUQwZjVXTjNW?=
 =?utf-8?B?RC82NnpkYlVwZm5XSEhNMmx2Q3UyNTFMRWlPTENlSkphMHNrSlV3SFJFUS91?=
 =?utf-8?B?V2NYS1FySEE5Mm9TZU52N2t0Q20vZWJhOTlWQUV6ZHAwUlllVzdXYXpiZ3B0?=
 =?utf-8?B?dHVYM3dTMlRNZGxUYWNkb0VzcVc1ejk0eEhPYjFJRS9mUWt6dG9idzZ3T2Ju?=
 =?utf-8?B?ZDJ0amQ2T0c5c2VVakdoNTlrQmFMaGFvbEFPbFNPRlljNWF1b3V6Tm5vWm4x?=
 =?utf-8?B?a0w0dTQ1NndPVnJjTlY5Wm0vZ0FpNVVmVXdTako5YmZEellWZ2h5Q0xaeHY0?=
 =?utf-8?B?U1JRclJ4WFhBaG4zRzNDaVpTMlFDOUVIaUZJcG14amdXUHZJUzVIcC9QMzV3?=
 =?utf-8?B?MGZVTG1acHlnRjZvSHk1UEJ4WVE1cklPNlVPTHZlTkU5amdlVDVaMXh5NU4v?=
 =?utf-8?B?Z3NzZG9NKzEyb0JhdXVuK1NWSDFVNFlPelNvTmRVT2hoRUZKZDVORGQxTC94?=
 =?utf-8?B?Smh1VU5qcURFMjEwTTBIbHFWRHNoMStwZnRMNEpmeWQ0UktORlNBSW00bnZG?=
 =?utf-8?B?ZHN3Ymd4TnJFS2xaMnNYYVl2YzI2SEMxZGNiZlV6NjhFblpKQWhVNGFtQjhj?=
 =?utf-8?Q?Hf5GuefT34766jZxg25n7Y0sNPLQDY0O5fXkowP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR01MB8297.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YUZhME14UXQvdzI1S0pvOWlPWDcrT0R4a0pJdFhaR2pNMUVHdkpqMm1HdHhX?=
 =?utf-8?B?MWpYVEdjOXRzUWZxYkR5RXVoSlFpa0FacU1zZmgyeTJGbUJWYVF6UUFEUUMz?=
 =?utf-8?B?eGFaN2JpNi9xUEp4V2dGZTB4V1JxUU1sU2RFYlc0ZWhCbXBnRFhwVkFoV1pj?=
 =?utf-8?B?Mk9sTTMrMS82QmkyQVVJdFc1dkxtZ29WaDAvMkxKUnprYWM3cU0xQVlqQm93?=
 =?utf-8?B?TzV0cXA1ak9IOHQ0enRoUExlaWs4ZHloYUZ2cERKNmFEVDBwUEZoVVBhYS9O?=
 =?utf-8?B?YkNteEZweTNWS0NheHVWSEVPNXBBNXBWSEIvSlBQQS9aN21RS1MwWUsrWkVq?=
 =?utf-8?B?Y0lQVVN3SGw2SHhmanR3YkhOVHlBSThuOWUxNnNMejFuQUFuUzFkTnVETXdX?=
 =?utf-8?B?WmpFdUo3aFhMSG1Va25lRmo4RkpYR0ZyaTJwTFZGZytLZkZySzVtc205M3VN?=
 =?utf-8?B?NGxwbGdOd2xRNVhzQkEyNEhyUWdsaDlpNWtGVllaNm9wazJRaUEwT0UxSGdh?=
 =?utf-8?B?NkxwMEc2NUttZ3dYWjZrd0V4allVb0QyWjVndVVuTndaemhYcjRrU1owYWVW?=
 =?utf-8?B?Q2JscjZqRURBbnh0eXk3S216WDI5aHRUdnJMaTY4TVhKVHNkeUtRR0RtUDNj?=
 =?utf-8?B?WE1TWmEyNCtlVG0ySy9WOTNpQ0E1bVRqaHhBcGl5RU1qaEJYaGI5akR5bXBW?=
 =?utf-8?B?VER6L2VDTTd6UEFoVFdyMENuRlA0ZUhMWStzNmtRbnc3UEhsSkkwZmRrWEN3?=
 =?utf-8?B?K2lYWkUyUG5xZkx1ZUFCVjI3VU1PNWFFU2w0ak1Fb1dhSWJrbWdJYllURkpo?=
 =?utf-8?B?UUIzdkE0dUZUdWhSdHVGSytTd1BJQjJ1Y1hDcHU3TE5ZanhSbGthZVVubFl2?=
 =?utf-8?B?enBLaHExaDhSMSszS0ZuakxQVjRWKzFUd0dCMlZjWXduNEZ5blBwalV3NnVs?=
 =?utf-8?B?bExMSlp5ZWNpZ09qcC9Ub0dHQzNqYWhQcEdRTmh0RzRlYUgvWDl3ZS94a2RP?=
 =?utf-8?B?RkVVOWIzNmdFQmVJVkxINEttNklpeTNpWkhyVmt3TE5UVlpKNWwyWGxDZkpP?=
 =?utf-8?B?MU1iU0lEWUM2dlNuV0o4VXB3bmFldGg4eEdZWUZKWnp6YjVtalhUeXIxKy9l?=
 =?utf-8?B?VGRTcXRQaTNzM0tyWEF4bURGRXVZaWlYc1lXL3NXQjJsTmRTUjBYdUZHaHN5?=
 =?utf-8?B?bFdQWjlyRFZ3cHUzaWJvTlMraWNsbnFIQVJhemNvSXFLamg3YWF5RXZZL2N2?=
 =?utf-8?B?V3ZWSTNwTkdPOFFCbWFLcC8wNjRMWUpyUW5SOFZESldHc0MxYUUvNThPcTl4?=
 =?utf-8?B?a1N6cHBuOXBDM29ray8vZXNPTnJIRk5xSXdiMWNuZEpJSGZ2RDEvTWhHTHZm?=
 =?utf-8?B?NFBpNUpzeWo0Y0ZzUkQ0M2JiY0M0MXQ5RnFJSHhRMTFPRkJCMUNIV0JrRS82?=
 =?utf-8?B?Lzh3cHZpWXJaMlZRNnd5QjRsSnBOYjNLV0YvcEgyR2NldVgrZ3pjZXVob2Rw?=
 =?utf-8?B?eDRxVUJic0ZsTVVLeEdTTk9CWHdFUDEvS1pETTVvUzlJcFZrK3RHZFJkcGEx?=
 =?utf-8?B?MFdPaDNnMGQwZXc2c0ZBOGhYdWNMOG15Mm82NS95citNbkJLZ1lvZXJPczF5?=
 =?utf-8?B?REZzeHZNOG1YS25Hc1hiV1hXMFVJMkNlZFVFYU5zdDdtTWVqQmpIOEkvTzYy?=
 =?utf-8?B?OU5pazdxZ05ZdGJONjkyamJMT2o0eVM0MHVyOFMyQjJJbzIvSVRVVnp4VUEz?=
 =?utf-8?B?YVlKNXNaTVlRTW5mMHQySU5tUHAzMzl6Nkl5a3JSOUZucC82SHM1YzZTT2FC?=
 =?utf-8?B?ZG1qNnN2b1o5Zm1rYUowSXd1R2VBSnptRHp6MlJhRnZBY0lQWnIwTElFb3Fl?=
 =?utf-8?B?UDI3eHlmbmVwdysxd2dqR0FueWlMWW85RWUyQVc0TDhGQzBmT1Vib1E4aVNL?=
 =?utf-8?B?Q1NxbGFuc0lmWGZpdm5BMXI0V3JFTytldm5KRXNaUHdhOTU3Q1pOUzdBVnVh?=
 =?utf-8?B?WkRGSlFjYklkcGtEQUhUa1JYcmw3RTJRcm8vOCs1Zkx3NUpnVWJHTVhHU2Zs?=
 =?utf-8?B?aDFCaVBYdlh5ZXNkMkhuY1Jlb0Fvb1BqclE4TW9HakdFOHduVWVLRk5ubHRT?=
 =?utf-8?B?TEJQclVOMzlSeEJHR3IxU2tvQ1phZGxCaFRoZ3o1M2FyY3EwaW5BTzEzL0tk?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2b6883-59e8-400f-c218-08dd3df3e6d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR01MB8297.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 10:26:31.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3MHdgKLdYsIBo421ZyJ4hyZ31AoGwBbJyJnaJoLELx7Hw+VTpJjg5RHzXwC0jVmDtKry+ZqqsotY2RzegYcLVPeJFayQeKfJG+s2KnxxHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6992
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jan 2025 10:28:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17090

Hi Antonin,

Antonin Godard schrieb am Mo 06. Jan, 10:37 (+0100):
> On Thu Jan 2, 2025 at 10:23 PM CET, J=C3=B6rg Sommer via lists.yoctoproje=
ct.org wrote:
> > From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> >
> > To give an example how the YAML format can be used, the example of the
> > warnings logger should be converted to YAML.
>=20
> In https://docs.python.org/3/library/logging.config.html#logging.config.l=
isten
> the note says:

But does this apply here? As far as I understand the code the config gets
loaded in

* lib/bb/ui/knotty.py:393: logconfigfile, error =3D server.runCommand([cmd,=
 "BB_LOGCONFIG"])
* lib/bb/ui/knotty.py:424:  =E2=80=A6, logconfigfile =3D _log_settings_from=
_server(server, params.observe_only)
* lib/bb/ui/knotty.py:590: conf =3D bb.msg.setLoggingConfig(logconfig, logc=
onfigfile)

And in setLoggingConfig is no difference between JSON and YAML:

```
def setLoggingConfig(defaultconfig, userconfigfile=3DNone):
    logconfig =3D copy.deepcopy(defaultconfig)

    if userconfigfile:
        with open(os.path.normpath(userconfigfile), 'r') as f:
            if userconfigfile.endswith('.yml') or userconfigfile.endswith('=
.yaml'):
                import yaml
                userconfig =3D yaml.safe_load(f)
            elif userconfigfile.endswith('.json') or userconfigfile.endswit=
h('.cfg'):
                import json
                userconfig =3D json.load(f)
            else:
                raise BaseException("Unrecognized file format: %s" % userco=
nfigfile)

            if userconfig.get('bitbake_merge', True):
                logconfig =3D mergeLoggingConfig(logconfig, userconfig)
            else:
                # Replace the entire default config
                logconfig =3D userconfig
```

The BB_LOGCONFIG never goes to the python function
logging.config.fileConfig() which has the behaviour you pointed to.

>   If you want to send configurations to the listener which don=E2=80=99t =
disable existing
>   loggers, you will need to use a JSON format for the configuration, whic=
h will
>   use dictConfig() for configuration. This method allows you to specify
>   disable_existing_loggers as False in the configuration you send.
>=20
> I believe this is the reason why JSON was used. So the disable_existing_l=
oggers
> usage in Yaml below is ineffective.

> > + formatters: + warnlogFormatter: + '()': bb.msg.BBLogFormatter +
> > format: '%(levelname)s: %(message)s'
> > =20
> > -      "@disable_existing_loggers": false
>=20
> This is strange, maybe a typo? We should probably remove the "@" here.

Yes, I found nowhere in Python disable_existing_loggers with =E2=80=9C@=E2=
=80=9D, and no
special handling of it in BitBake.

Regard, J=C3=B6rg

--=20
Der Hase l=C3=A4uft schneller als der Fuchs,
denn der Hase l=C3=A4uft um sein Leben.

Navimatix GmbH           T: 03641 - 327 99 0
Tatzendpromenade 2       F: 03641 - 526 306
07745 Jena               www.navimatix.de

Gesch=C3=A4ftsf=C3=BChrer: Steffen Sp=C3=A4the, Jan Rommeley
Registergericht: Amtsgericht Jena, HRB 501480

