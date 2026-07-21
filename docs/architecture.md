# Architecture decisions

## Scope and platform boundary

This reference begins at the subscription workload boundary. A mature enterprise platform would normally provide management groups, policy initiatives, identity governance, hub networking, DNS forwarding and subscription vending before this stack is deployed.

## Network tiers

| Subnet | Intended use | Key boundary |
|---|---|---|
| Platform | Application platforms, agents and internal services | HTTPS administration only from the management subnet |
| Data | Databases and caches | Selected database ports from the platform subnet |
| Private endpoints | Private Link network interfaces | No general workload placement |
| Management | Controlled administration components | No direct inbound access from the Internet service tag |

The example deliberately avoids broad `VirtualNetwork` inbound rules. Additional flows should be added because a known service needs them, not because two resources share a VNet.

## Identity

The user-assigned identity is independent of a compute resource so its lifecycle and role assignments can be reviewed explicitly. It receives a narrow monitoring role at the Log Analytics workspace. Application data-plane roles should be granted on the exact storage account, vault, registry or database required.

Human access should use Microsoft Entra groups, privileged workflows and time-bounded role activation rather than persistent individual assignments.

## Private Link and DNS

The storage public endpoint is disabled. A Blob private endpoint is placed in a dedicated subnet and registered in `privatelink.blob.core.windows.net`, which is linked to the VNet.

In a hub-and-spoke estate, the DNS zone would commonly be centralized. Spokes would use centrally managed links and DNS forwarding rather than creating duplicate private zones.

## Observability

Network security group event and rule-counter logs are sent to Log Analytics. Retention is configurable but constrained to at least 30 days in this example. A production platform should select diagnostic categories per resource, set cost controls and route security data according to the organization’s monitoring architecture.

## Storage security

The account enforces TLS 1.2 or later, disables public network access, disables shared keys, prefers OAuth, prevents anonymous nested-item access and enables infrastructure encryption, versioning and soft delete.

## Delivery controls

Recommended pipeline gates include:

- `terraform fmt -check -recursive`;
- `terraform validate`;
- provider lock-file review;
- linting and infrastructure security scanning;
- policy-as-code evaluation;
- reviewed plans using short-lived workload identity;
- drift detection after deployment.
