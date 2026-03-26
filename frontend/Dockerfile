# ---- Build Stage ----
FROM node:22-alpine AS build

WORKDIR /app

# Cache dependencies first
COPY package.json package-lock.json ./
RUN npm ci

# Copy rest of the code
COPY . .

# Build app
RUN npm run build


# ---- Run Stage ----
FROM nginx:alpine

# Remove default config (cleaner)
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy only built files
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]