Received: from EUR03-VE1-obe.outbound.protection.outlook.com (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.87])
 by mx.groups.io with SMTP id smtpd.web12.66979.1629360145807955267
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Aug 2021 01:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=IR4jRErz;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.5.87, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLV3ppEBwHnpXJwDnA1xtSiWLwmMnabFJU6DznCrYnIM1awiDo0aTnw7VAJEm7Oo3hCykVy7H83vKAvMEoZtmQwDSH9sWDnb1CQznQg2R4qSorknTl51//VmPA3bwxCL+Jxx0UxHPDgtQQA2RLIjO/DlmawMOC4J2q9GAWSvegWz1RQAG2NrIev15MvnttWuapVj7ebjqqjbWYFRy0DQK8FdUubZbPcfj4e57YSdm95OThTgtoGexsLfFjwuzFvG2OKY5W3TscyvK4X0HDJgifekyfmPcVBStY8s9wfJsfhkB45U0o+NhklvQR0HtXjzSe7uZIBbp9LJiQIqk3Iq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ONQ4V/tUTqn2uJ8/Y2t65lYygJ+e7gKzJh8yUmfKeI=;
 b=mXY6wAFypS2Bq36RJLPciYDkFNo72WhfM5HJ4DkEKIO7yaWnfmOlkVHQwnJtiNu7PASpeGZLC4FIG8Nv5UMfvy7uniMYESP8dgnHVXGkf4D9Rclx/LMJJr5kN4tX4qIH5wvr+cEf6UoO+CoU7SGzIEB9Hjf1rceo2witNCAcS+JHBGm20REXRPWU5tmmTYNXPVAqqOwXq6SS96nzIt1npcuheeBOvCnd6Pme5yf+4/OfZT/+/kdvAToto+AL5Zry2WOUQlofYl0ot69Gtuw5kzp/mF/4JUXV+CguKgq8lHK18j8tkj05xFZTRa1pfmftA/EIC11scSaUBFwLS5N5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ONQ4V/tUTqn2uJ8/Y2t65lYygJ+e7gKzJh8yUmfKeI=;
 b=IR4jRErz6s75XEw7h5PvrqW/TRo2J2PE7s8W54GDR1uEhZpZyQTjBRrhfmgss65ExPTpFykJtg0o2GUgFUx39ye+0C8TDES8ZRzoJ2rTxOVTBGqtO4uL9U0gRKp9d3YPTy8aAbEfweAQ2TmTo4XEivaSsjQ7GRHxT/DopgxF4+A=
Authentication-Results: agilent.com; dkim=none (message not signed)
 header.d=none;agilent.com; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB4434.eurprd04.prod.outlook.com
 (2603:10a6:208:6c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Thu, 19 Aug
 2021 08:02:22 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::cd35:af76:7542:4dd6]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::cd35:af76:7542:4dd6%7]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 08:02:22 +0000
Date: Thu, 19 Aug 2021 10:02:19 +0200
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: chris.laplante@agilent.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Trouble capturing layer revision as variable in recipe
Message-ID: <20210819080219.sd2huy4uh4vpniwe@fedora>
References: <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (92.42.140.82) by FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Thu, 19 Aug 2021 08:02:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988c2c4c-3cab-419e-b288-08d962e7ac73
X-MS-TrafficTypeDiagnostic: AM0PR04MB4434:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB4434781C7E4A67FD622A1A53C2C09@AM0PR04MB4434.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0dGiOS1g3WzFwvXQEx2tdrU/cX+C492LGrXF1zZ4gw5lODM3Kzl3Y43ARBxQkwAtQmkQUHhu+5ogy0SyX/NMlttGO+2t+LxSmoy2wLqpYovnT4gkp6nlM5Ib8JwaMozI01aMgzLvIwcXbvDXshEE1gTVG2RVyDK4Rza6i+wIGSBxy9UqtLWQlMLgcwcXHCCwNeFRpVItljbNdM36JZNUKOv2r38iPKbR0BGTaZebkAKetzcPGkIRXoZTx6U0vjbyJCo5ZGtLvOHqZ9WuQkT7ekV3793h/fh8YiYbzFsoWZeoKABWNSDrKv4CBymT32UhgE+3KZnPpFiiLstgaBDxgV2lmvqQmwUc4RhJXxExJukDRyi9jmETmlUH+TsicKC7gQaEtDiikkxRoJFTfqIp0hGQRHcBjzfvHKTQzCK+G7zBzNL/rmLzebAbNbWyv746PAmDkYJDB/2kT1sa8uSaTa6WoeUGCcESoETDF6CKLPfOqLpEuQG2vlutTri4ZMAgMVJR2F/ECdwu5C5Z29RpnOuqXIH2hECtSIWaECfncvTVej16RudwF33gK4Jp1S8QHSgDZVxlrJDme/yM2zCQfCffbd8cM4KG4BTBauZQkdXl3fdR5rtKkn+tm5C8wdQImktStgHgRfxlLnH3AKlsjOQP1mvPN3TzX1nZgqUZpqx9pyB4O2og3XTej0/vjXX1KA9llzxZpzk3HhpMKjGegA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(376002)(346002)(396003)(366004)(5660300002)(6496006)(4326008)(1076003)(186003)(9576002)(86362001)(38350700002)(38100700002)(316002)(956004)(66556008)(478600001)(66476007)(66946007)(9686003)(55016002)(83380400001)(26005)(6916009)(33716001)(8676002)(52116002)(8936002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GJEICzlH23FddtJul7C6IDjZyfDzE+6vzFzMvZ0FtCvpqbscV8fpV+tD06u5?=
 =?us-ascii?Q?Mh7cjn06/kvNBBsSCuXMNbtHUd/vDxiCGJm26m7eGglg6NusiF4NYWJitmES?=
 =?us-ascii?Q?gGR1zdDONSaDMkaCZIPmM5JkRGjwonsWPi1DAnb+rnYEyug/13BNcc+Dltjw?=
 =?us-ascii?Q?jsvr7jOk3yLm+2ZeKU4lzkwiuCQAVxmrsxs6YbHPHv0uSLOS/8hAsKP94boF?=
 =?us-ascii?Q?1yjZ6EgQsb2KxLiFzPl1pzk/TlYfUEiVsDCbEWBjjqrU9m8nrrzjmqPqzvai?=
 =?us-ascii?Q?iUa0JAdWYGg5/QiN5T4FKGgPc9VPM+XVsjXINjpGvFJFRDrp3cE1N/mu3aHs?=
 =?us-ascii?Q?BwLZcFs3M+hijlcqA1+8/mt0N8GP0/OqWlWDbvHqmuqfYfO/XiV64vEKoQiW?=
 =?us-ascii?Q?zYUBsc+dbR64CtVUdF/FjugyCBkKvqB4bkyxFAXUL58K2EeMVgZTVI+qBBNP?=
 =?us-ascii?Q?lWKtwQA3p4dvyXdCI3UdhDq983ckL26y48tqMdotcPMXLTENkHnvV7L8EAys?=
 =?us-ascii?Q?NhY7O8hNpIEHYK5iAGr5e1Ph/l4TpibusXxTsXl8htl6U5fNY7wd4cSLp1Mo?=
 =?us-ascii?Q?JdkkHoVAVFbQtfrXLOkdHc0xMm1T5eW+4/MoKec6NrnR3RSsiKfekzCtvDfY?=
 =?us-ascii?Q?B1IPuGDEAPD7XjFkSEmM9+G8Dz32Bgpm8k3uaiVa7fwKxI67sg8TugMU7jre?=
 =?us-ascii?Q?ylWDA3zTShzgYim/twDOzn5p0C+xkgsYG01L1CgSAviEPGpQQg19+CR8Os9l?=
 =?us-ascii?Q?1GvMb0c/k8n9BNvby3Wr/B7sc5hohzuxU5SbSGdqVF4Yv/gBfvvxZoMEMcNa?=
 =?us-ascii?Q?cvz1WjiyIJ4ybdg9jcNphmB+FNmNCnpfhL/1jrROLcz2+GNaRhPN1UPL9eAE?=
 =?us-ascii?Q?08Y19MxluR+V2F5dFWwbf8xHq/GVcBhx8aRl+yiD8HrQjwdT+RresHQo7Hj3?=
 =?us-ascii?Q?Pe7RH8yWRseKBw2SKWJJcLflnzWieWk49lUUp2py6B/xvGkIF/8uyhYTobX6?=
 =?us-ascii?Q?RTEMsOptqy9rNgoM49mp6a2Un3nICW1wUkRNoTvmdy2+QgnkzI1yqzmTyUeP?=
 =?us-ascii?Q?0oTTbjAysOZ56fpz4q6pjCfsFPv9KEVCTIGiwfo9BuXewxgTnN6Yqg1707Wu?=
 =?us-ascii?Q?QDsdOQmDXkZ5w//teS8vwFnN7th3Del5W+6XHwpm6fSQJvFOKTwjDMO5uGuQ?=
 =?us-ascii?Q?0SjnYB/NMqSl10gOei6nDdvH9Ljvq3I31BegjUkhDxmGXg022RP3rPJY8wFx?=
 =?us-ascii?Q?cf6Pn0P4MugykWTaBTl5Qe1iRBAIQYFn3MONdRWuBh03dYDeeNhqXWpPPOP6?=
 =?us-ascii?Q?kXrWMn7wwqANvYcUIuvzxNt4?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988c2c4c-3cab-419e-b288-08d962e7ac73
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 08:02:22.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN98nflxq6ybk86maLorM53u4yiPePKNKj+6tTWzNil6+oWQ3CkkKyakgbJw7gXltwVtSqKdLJbEjmyJYFMYTtfSu3HM3PekPatmi6Dr3ATKGTbUTq6j2ROc6MwOoPSn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4434
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

On Wed, Aug 18, 2021 at 07:21:05PM +0000, Chris Laplante via lists.openembedded.org wrote:
> Hello all,
> 
> We are on Yocto 'zeus'.
> 
> Our u-boot recipe generates a versions.txt file containing the git commit of the U-Boot source tree. It was pointed out that since recipes can patch the source, just the source commit ID isn't quite enough. So we wanted to also include the git commit of the layer housing the recipe. Call this layer "meta-our-layer".
> 
> This is the implementation we tried:
> 
> def get_layer_path(d, name):
>     layer_list = (d.getVar("BBLAYERS") or "").split()
>     return [os.path.abspath(l) for l in layer_list if l.endswith(name)][0]
> 
> def get_meta_our_layer_commit(d):
>     import subprocess
>     output = subprocess.check_output(["git", "rev-parse", "HEAD"], universal_newlines=True, cwd=d.getVar("OUR_LAYER_PATH"))
>     return output.strip()
> 
> OUR_LAYER_PATH := "${@get_layer_path(d, "meta-our-layer")}"
> 

Maybe LAYERDIR works?

But for sure THISDIR would work.

So just replace cwd with d.getVar("THISDIR") instead of the complex
handling since git rev-parse can run in a dir different from the root.

> OUR_LAYER_COMMIT = "${@get_meta_our_layer_commit(d)}"
> OUR_LAYER_COMMIT[vardepvalue] = "${@get_meta_our_layer_commit(d)}"
> 
> do_deploy_append() {
>     echo "meta-our-layer:${OUR_LAYER_COMMIT}" >> ${DEPLOYDIR}/versions.txt
> }
> 

If you have logic around this versions.txt make sure this logic depends
on the do_deploy of u-boot recipe (DEPENDS/RDEPENDS is *NOT* enough, it
is susceptible to race conditions).

Cheers,
Quentin
